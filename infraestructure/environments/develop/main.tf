module "vpc" {
  source               = "../../modules/vpc"
  cidr_block           = var.cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  availability_zones   = var.availability_zones
  env_short            = var.env_short
  org_account          = var.org_account
}

module "key-pair" {
  source         = "../../modules/key-pair"
  key_pair_ec2   = var.key_pair_ec2
  algorithm_type = var.algorithm_type
  rsa_bits       = var.rsa_bits
  env_short      = var.env_short
}

module "ec2" {
  source             = "../../modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = element(module.vpc.private_subnet_ids, 0)
  key_name           = module.key-pair.key_name
  primary_private_ip = var.primary_private_ip
  trunk_private_ip   = var.trunk_private_ip
  security_group_ids = [aws_security_group.my_sg.id]
  vpc_id             = module.vpc.vpc_id
}

module "ecs" {
  source                 = "../../modules/ecs"
  subnet_id              = element(module.vpc.private_subnet_ids, 0)
  ecs_cluster_name       = "sisorg-${var.env_short}"
  security_group_id      = aws_security_group.my_sg.id
  ecs_task_exec_role_arn = aws_iam_role.ecs_task_exec_role.arn
  env_short              = var.env_short
  org_account            = var.org_account
}

resource "aws_security_group" "my_sg" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }
}

# Ensure ECS Task Execution Role is created
resource "aws_iam_role" "ecs_task_exec_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      }
    }
  ]
}
POLICY
}
