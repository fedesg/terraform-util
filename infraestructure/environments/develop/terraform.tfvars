# AWS Region Configuration
aws_region = "us-east-1"

# EC2 Instance Configuration
// Linux
ami_id = "ami-02c21308fed24a8ab"
// Microsoft Windows Server 2022 Base
#ami_id        = "ami-07cc1bbe145f35b58"
instance_type = "t3.micro"
#key_name      = "my-ssh-key"

# Networking Configuration
primary_private_ip = "10.0.4.100"
trunk_private_ip   = "10.0.4.101"
#security_group_ids = ["sg-0123456789abcdef0"]

# VPC Configuration
cidr_block           = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
public_subnet_count  = 3
private_subnet_count = 3
availability_zones   = ["us-east-1a", "us-east-1b"]

# Tags Configuration
tags = {
  "Name"                  = "VPC_DEVELOP"
  "Environment"           = "Develop"
  "Project"               = "Microservice"
  "sisorg:service"        = "infra"
  "sisorg:environment"    = "develop"
  "sisorg:application"    = "Entry"
  "sisorg:taggingVersion" = "1.0.0"
  "sisorg:organization"   = "develop"
  "sisorg:automated"      = "yes"
}

security_group_ids = ["sg-0123456789abcdef0"]
subnet_id          = "subnet-0123456789abcdef0"
