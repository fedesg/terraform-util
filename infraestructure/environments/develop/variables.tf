# AWS Region Configuration
variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
}

# Environment Configuration
variable "env_short" {
  description = "The environment short name"
  type        = string
}
variable "env_tag" {
  description = "The environment tag name"
  type        = string
}
variable "env_ecs_task_requires_compatibilities" {
  description = "The environment ecs task compatibilities"
  type        = string
}

# Organization and Account Configuration
variable "org_account" {
  description = "The organization account"
  type        = string
}

# AMI Configuration
variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

# EC2 Instance Type Configuration
variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
}

# Networking Configuration
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
  default     = ["sg-0123456789abcdef0"]
}
variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
  default     = "subnet-0123456789abcdef0"
}

# VPC Configuration
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

# Subnet Count Configuration
variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
}
variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
}

# Availability Zones Configuration
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

# Key Pair Configuration
variable "algorithm_type" {
  description = "The type of the SSH key to use"
  type        = string
}
variable "rsa_bits" {
  description = "The number of bits in the SSH key to use"
  type        = number
}
variable "key_pair_ec2" {
  description = "The name of the SSH key to use"
  type        = string
}
