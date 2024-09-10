# Environment Configuration
variable "env_short" {
  description = "The environment short name"
  type        = string
}

# Organization and Account Configuration
variable "org_account" {
  description = "The organization account"
  type        = string
}

variable "sisorg_subnet_1_public" {
  description = "The ID of the public subnet in which the EC2 instance will be launched"
}

variable "sisorg_sg_utility" {
  description = "The ID of the security group for the utility instance"
}

variable "env_utility_instance" {
  description = "Instance type for the utility EC2 instance"
  type        = string
  default     = "t3.micro"  # Set a default value or override it in your tfvars file
}

variable "ami_ubuntu" {
  description = "AMI ID for the Ubuntu instance"
  type        = string
}

variable "env_tag" {
  description = "Environment tag (e.g., Development, Production)"
  type        = string
}

variable "cidr_block_vpc" {
  description = "CIDR block for the VPC"
  type        = string
}
