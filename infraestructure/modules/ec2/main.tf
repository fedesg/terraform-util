# Retrieves the most recent Amazon Linux 2 AMI ID for EC2 instances.
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# Creates an IAM role for the ECS instances.
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs-instance-role"

  # IAM policy that allows EC2 to assume the role.
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

# Creates an IAM instance profile that links the IAM role to EC2 instances.
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}

# Defines a security group with inbound SSH access and outbound access to all IPs.
resource "aws_security_group" "example" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creates an EC2 instance with the specified AMI, instance type, and security groups.
resource "aws_instance" "this" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  key_name        = var.key_name
  security_groups = var.security_group_ids
}

# Defines the primary network interface for the EC2 instance.
resource "aws_network_interface" "primary" {
  subnet_id       = var.subnet_id
  private_ips     = [var.primary_private_ip]
  security_groups = var.security_group_ids
}

# Defines a trunk network interface for ENI trunking.
resource "aws_network_interface" "trunk" {
  subnet_id       = var.subnet_id
  private_ips     = [var.trunk_private_ip]
  security_groups = var.security_group_ids
}

# Attaches the trunk network interface to the EC2 instance.
resource "aws_network_interface_attachment" "trunk_attachment" {
  instance_id          = aws_instance.this.id
  network_interface_id = aws_network_interface.trunk.id
  device_index         = 1
}

# Creates a launch configuration for ECS, specifying the AMI, instance type, and security groups.
resource "aws_launch_configuration" "ecs" {
  name                        = "ecs-launch-config"
  image_id                    = data.aws_ami.amazon_linux.id
  instance_type               = "t3.medium"
  iam_instance_profile        = aws_iam_instance_profile.ecs_instance_profile.name
  key_name                    = var.key_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.example.id]
}

