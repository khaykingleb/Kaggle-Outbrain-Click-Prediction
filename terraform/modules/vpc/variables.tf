variable "tags" {
  description = "Common tags of the project."
  type        = map(string)
  default     = {}
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
