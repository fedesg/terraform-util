provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source               = "../../modules/vpc"
  cidr_block           = var.cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# module "iam" {
#   source = "../../modules/iam"
#   tags   = var.tags
# }

resource "aws_security_group" "my_sg" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ec2 port from ssh"
  }
}

module "ec2" {
  source             = "../../modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = element(module.vpc.public_subnet_ids, 0)
  #key_name           = var.key_name
  primary_private_ip = var.primary_private_ip
  trunk_private_ip   = var.trunk_private_ip
  security_group_ids = [aws_security_group.my_sg.id]
  tags               = var.tags
}
