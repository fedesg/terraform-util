# AWS Region Configuration
aws_region = "us-east-1"

# Environment Configuration
env_short                             = "dev"
env_tag                               = "development"
env_ecs_task_requires_compatibilities = "EC2"

# Organization and Account Configuration
org_account = "825765408764"

# EC2 Instance Configuration
ami_id = "ami-02c21308fed24a8ab" # Linux AMI
# ami_id     = "ami-07cc1bbe145f35b58" # Windows Server AMI (Commented)
instance_type = "t3.micro"

# Networking Configuration
primary_private_ip = "10.0.4.100"
trunk_private_ip   = "10.0.4.101"

# VPC Configuration
cidr_block           = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
public_subnet_count  = 3
private_subnet_count = 3
availability_zones   = ["us-east-1a", "us-east-1b"]

# Security Group Configuration
security_group_ids = ["sg-0123456789abcdef0"]

# Subnet Configuration
subnet_id = "subnet-0123456789abcdef0"

# Key Pair Configuration
algorithm_type = "RSA"
rsa_bits       = 4096
key_pair_ec2   = "kp_ec2"



