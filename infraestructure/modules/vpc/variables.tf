# VPC Configuration

# The IP range for the VPC.
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

# List of CIDR blocks for the public subnets.
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

# List of CIDR blocks for the private subnets.
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

# Number of public subnets to create.
variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
}

# Number of private subnets to create.
variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
}

# List of availability zones to use for subnets.
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

# Environment Configuration
# Short name for the environment (e.g., dev, prod).
variable "env_short" {
  description = "The environment short name"
  type        = string
}

# Organization and Account Configuration
# AWS organization account ID.
variable "org_account" {
  description = "The organization account"
  type        = string
}
