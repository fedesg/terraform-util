variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key to use"
  type        = string
}

variable "primary_private_ip" {
  description = "Primary ENI private IP"
  type        = string
}

variable "trunk_private_ip" {
  description = "Trunk ENI private IP"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = ["sg-0123456789abcdef0"] # Example default value
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
  default     = "subnet-0123456789abcdef0" # Example default value
}

variable "tags" {
  description = "Tags to assign to the instance"
  type        = map(string)
}

variable "cidr_block" {
  # description = "The CIDR block for the VPC"
  # type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}
