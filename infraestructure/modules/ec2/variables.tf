variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
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
}
