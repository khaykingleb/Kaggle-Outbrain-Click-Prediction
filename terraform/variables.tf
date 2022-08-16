variable "project_name" {
  description = "Project name."
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment type of the project."
  type        = string
  default     = ""
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = ""
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet inside the VPC."
  type        = string
  default     = ""
}

variable "private_subnets_cidr_block" {
  description = "The CIDR block for the private subnet inside the VPC."
  type        = string
  default     = ""
}


/*
variable "ec2_instance_type" {
  description = "Instance type to use for the EC2."
  type        = string
  default     = null
}

variable "ec2_ami_id" {
  description = "AMI ID to use for the instance."
  type        = string
  default     = null
}

variable "ec2_cpu_core_count" {
  description = "Number of CPU cores for the instance."
  type        = number
  default     = null
}

variable "ec2_cpu_threads_per_core" {
  description = "Number of CPU threads per core for the instance."
  type        = number
  default     = null
}



variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Whether to provision NAT Gateways for each of private networks or not."
  type        = bool
  default     = false
}

variable "nat_gateway_destination_cidr_block" {
  description = "Destination route for private NAT Gateway."
  type        = string
  default     = "0.0.0.0/0"
}

variable "erm_job_name" {
    description = "Name of the job flow for the AWS EMR."
    type        = string
    default     = ""
}

variable "emr_release_label" {
  description = "Release label for the AWS EMR release."
  type        = string
  default     = ""
}

variable "emr_applications" {
    description = "Case-insensitive list of applications for AWS EMR to install and configure when launching the cluster."
    type = list(string)
    default = []
}
*/
