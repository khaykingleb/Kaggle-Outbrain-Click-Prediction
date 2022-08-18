
resource "aws_emr_cluster" "this" {
  name          = "${var.tags["project_name"]}-job"
  release_label = var.release_label
  applications  = var.applications
  log_uri       = "s3://${var.s3_log_bucket}/log"

  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true

  ebs_root_volume_size = var.root_volume_size

  ec2_attributes {
    subnet_id                         = var.subnet_id
    emr_managed_master_security_group = var.master_security_group_id
    emr_managed_slave_security_group  = var.slave_security_group_id
    instance_profile                  = var.instance_profile_arn
    key_name                          = var.key_name
  }

  master_instance_group {
    instance_type  = var.master_instance_type
    instance_count = var.master_instance_count
  }

  core_instance_group {
    instance_type  = var.slave_instance_type
    instance_count = var.slave_instance_count_desired

    ebs_config {
      size                 = var.slave_instance_volume_size
      type                 = var.slave_instance_volume_type
      volumes_per_instance = var.slave_instance_volume_count
    }

    autoscaling_policy = templatefile(
      "${path.module}/templates/autoscaling_policy.json.tpl",
      {
        min_capacity = var.slave_instance_count_min,
        max_capacity = var.slave_instance_count_max
      }
    )
  }

  # bootstrap_action {
  #     path = # !!!
  #     name = # !!!
  #     args = # !!!
  # }

  service_role = var.iam_erm_service_role_arn
  # autoscaling_role = # !!!!
  # security_configuration = # !!!!

  # configurations = "${data.template_file.configuration.rendered}"
  # or
  # configurations_json = # file()

  lifecycle {
    create_before_destroy = true
  }

  tags = merge({ name = "OCP-Cluster" }, var.tags)
}
