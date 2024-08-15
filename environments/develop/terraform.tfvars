# AWS Region Configuration
aws_region = "us-east-1"

# EC2 Instance Configuration
ami_id        = "ami-0ae8f15ae66fe8cda"
instance_type = "t3.micro"
#key_name      = "my-ssh-key"

# Networking Configuration
primary_private_ip = "10.0.1.100"
trunk_private_ip   = "10.0.1.101"
#security_group_ids = ["sg-0123456789abcdef0"]

# VPC Configuration
cidr_block           = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
public_subnet_count  = 2
private_subnet_count = 2
availability_zones = ["us-east-1a", "us-east-1b"]

# Tags Configuration
tags = {
  "Environment" = "Develop"
  "Project"     = "Microservice"
}

security_group_ids = ["sg-0123456789abcdef0"]
subnet_id = "subnet-0123456789abcdef0"
