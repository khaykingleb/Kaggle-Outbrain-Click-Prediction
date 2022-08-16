locals {
  region = "eu-north-1"
  #user_data = "../scripts/aws_ec2_user_data.sh"
  tags = {
    project_name = "${var.environment}-${var.project_name}"
  }
}

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block                 = var.cidr_block
  public_subnet_cidr_block   = var.public_subnet_cidr_block
  private_subnets_cidr_block = var.private_subnets_cidr_block

  tags = local.tags
}

module "s3" {
  source = "./modules/s3"
}

module "ec2_master" {
  source = "./modules/ec2_master"
}

module "ec2_slave" {
  source = "./modules/ec2_slave"
}

module "emr" {
  source = "./modules/emr"
}








/*
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  cidr            = var.cidr
  azs             = [data.aws_availability_zones.available.names[0]]
  private_subnets = [var.private_subnets[0]]
  public_subnets  = [var.public_subnets[0]]

  enable_nat_gateway                 = var.enable_nat_gateway
  nat_gateway_destination_cidr_block = var.nat_gateway_destination_cidr_block

  tags = merge({ Name = "OCP-VCP" }, local.common_tags)
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  ami                  = var.ec2_ami_id
  instance_type        = var.ec2_instance_type
  cpu_core_count       = var.ec2_cpu_core_count
  cpu_threads_per_core = var.ec2_cpu_threads_per_core

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.private_subnets[0]

  #user_data = file(local.user_data)

  tags = merge({ Name = "OCP-Compute-Server" }, local.common_tags)
}



resource "aws_emr_cluster" "this" {
  name = var.erm_job_name
  release_label = var.emr_release_label
  service_role  = #!!!!
  applications  = var.emr_applications

  tags = merge({ Name = "OCP-EMR-Cluster" }, local.common_tags)
}
*/
