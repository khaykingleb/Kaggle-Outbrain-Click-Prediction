locals {
  #user_data = "../scripts/aws_ec2_user_data.sh"
  tags = {
    project_name = "${var.environment}-${var.project_name}"
  }
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

  release_label = var.emr_release_label
  applications  = var.emr_applications
  s3_log_bucket = module.s3.log_bucket

  root_volume_size = var.root_volume_size

  subnet_id                = module.vpc.private_subnet_id
  master_security_group_id = module.vpc.default_security_group_id
  slave_security_group_id  = module.vpc.default_security_group_id
  instance_profile_arn     = module.security.iam_instance_profile_arn
  key_name                 = module.security.ssh_key_name

  master_instance_type  = var.master_instance_type
  master_instance_count = var.master_instance_count

  slave_instance_type          = var.slave_instance_type
  slave_instance_count_desired = var.slave_instance_count_desired
  slave_instance_count_min     = var.slave_instance_count_min
  slave_instance_count_max     = var.slave_instance_count_max
  slave_instance_volume_size   = var.slave_instance_volume_size
  slave_instance_volume_type   = var.slave_instance_volume_type
  slave_instance_volume_count  = var.slave_instance_volume_count

  iam_erm_service_role_arn = module.security.iam_erm_service_role_arn
  # autoscaling_role =
  # security_configuration =

  tags = local.tags
}
