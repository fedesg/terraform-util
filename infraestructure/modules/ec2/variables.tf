# Specifies the AMI ID for the EC2 instance.
variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

# Defines the type of EC2 instance to launch.
variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
}

# Specifies the subnet ID where the EC2 instance will be launched.
variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

# The name of the SSH key pair to use for EC2 instance access.
variable "key_name" {
  description = "The name of the SSH key to use"
  type        = string
}

# The private IP address for the primary network interface.
variable "primary_private_ip" {
  description = "Primary ENI private IP"
  type        = string
}

# The private IP address for the trunk network interface.
variable "trunk_private_ip" {
  description = "Trunk ENI private IP"
  type        = string
}

# A list of security group IDs to associate with the EC2 instance.
variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

# The VPC ID where the EC2 instance will be launched.
variable "vpc_id" {
  description = "The VPC ID in which the EC2 instance will be launched"
  type        = string
}
