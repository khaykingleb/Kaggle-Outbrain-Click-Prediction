locals {
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

module "security" {
  source = "./modules/security"

  tags = local.tags
}

module "s3" {
  source = "./modules/s3"

  tags = local.tags
}

module "emr" {
  source = "./modules/emr"
}
