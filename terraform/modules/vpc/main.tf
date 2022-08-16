################################################################################
# VPC
################################################################################

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = merge({ name = "OCP-VCP" }, var.tags)
}

resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id

  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ name = "OCP-Security-Group" }, var.tags)
}

################################################################################
# Subnets
################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge({ name = "OCP-Subnet-Public" }, var.tags)
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge({ name = "OCP-Subnet-Private" }, var.tags)
}

################################################################################
# Gateways
################################################################################

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge({ name = "OCP-IGW" }, var.tags)
}

resource "aws_eip" "for_nat_gateway" {
  vpc = true

  tags = merge({ name = "OCP-Elastic-IP" }, var.tags)
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.for_nat_gateway.id
  subnet_id     = aws_subnet.public.id

  tags = merge({ name = "OCP-NATGW" }, var.tags)

  depends_on = [aws_internet_gateway.this]
}

################################################################################
# Route Table for Public Subnet
################################################################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge({ name = "OCP-Route-Table-Public" }, var.tags)
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.id
}

################################################################################
# Route Table for Private Subnet
################################################################################

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge({ name = "OCP-Route-Table-Private" }, var.tags)
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private.id
}

################################################################################
# Default Network ACLs
################################################################################

resource "aws_default_network_acl" "this" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
