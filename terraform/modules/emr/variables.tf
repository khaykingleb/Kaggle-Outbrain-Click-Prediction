variable "tags" {
  description = "Common tags of the project."
  type        = map(string)
  default     = {}
}

variable "release_label" {
  description = "Release label for the AWS EMR."
  type        = string
  default     = ""
}

variable "applications" {
  description = "Case-insensitive list of applications for AWS EMR to install and configure when launching the cluster."
  type        = list(string)
  default     = []
}

variable "master_instance_type" {
  description = "EC2 instance type for the master node."
  type        = string
  default     = ""
}

variable "master_instance_count" {
  description = "Number of EC2 instances for the master group."
  type        = number
  default     = null
}

variable "slave_instance_type" {
  description = "EC2 instance type for the slave node."
  type        = string
  default     = ""
}

variable "slave_instance_count_desired" {
  description = "Desired number of EC2 instances for the slave group."
  type        = number
  default     = null
}

variable "slave_instance_count_min" {
  description = "Min number of EC2 instances for the slave group."
  type        = number
  default     = null
}

variable "slave_instance_count_max" {
  description = "Max number of EC2 instances for the slave group."
  type        = number
  default     = null
}

variable "slave_instance_volume_size" {
  description = "Volume size, in gibibytes (GiB), for the EC2 instance in the slave group. The size where HDFS will store data."
  type        = number
  default     = null
}

variable "slave_instance_volume_type" {
  description = "Volume type for the EC2 instance in the slave group."
  type        = string
  default     = ""
}

variable "slave_instance_volume_count" {
  description = "Number of EBS volumes to attach to each EC2 instance in the slave group."
  type        = number
  default     = null
}

variable "root_volume_size" {
  description = "Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance."
  type        = number
  default     = null
}

variable "s3_log_bucket" {
  description = "Name of the S3 log bucket."
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
  default     = ""
}

variable "master_security_group_id" {
  description = "The ID of the security group for the master group."
  type        = string
  default     = ""
}

variable "slave_security_group_id" {
  description = "The ID of the security group for the slave group."
  type        = string
  default     = ""
}

variable "iam_erm_service_role_arn" {
  description = "The Amazon Resource Name specifying the ERM service role."
  type        = string
  default     = ""
}

variable "instance_profile_arn" {
  description = "The Amazon Resource Name assigned by AWS to the instance profile."
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The key pair name used to control login access to EC2 instances."
  type        = string
  default     = ""
}
