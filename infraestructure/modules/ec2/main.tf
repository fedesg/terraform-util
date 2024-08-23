resource "aws_instance" "this" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  key_name        = aws_key_pair.sisorg_ec2_kp.key_name
  security_groups = var.security_group_ids
  #
  #   network_interface {
  #     device_index          = 0
  #     network_interface_id  = aws_network_interface.primary.id
  #   }
}

resource "aws_network_interface" "primary" {
  subnet_id       = var.subnet_id
  private_ips     = [var.primary_private_ip]
  security_groups = var.security_group_ids
}

resource "aws_network_interface" "trunk" {
  subnet_id       = var.subnet_id
  private_ips     = [var.trunk_private_ip]
  security_groups = var.security_group_ids
}

resource "aws_network_interface_attachment" "trunk_attachment" {
  instance_id          = aws_instance.this.id
  network_interface_id = aws_network_interface.trunk.id
  device_index         = 1
}

resource "aws_launch_configuration" "ecs" {
  name          = "ecs-launch-config"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.medium"

  iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name
  key_name             = var.key_name

  associate_public_ip_address = true
  security_groups             = [aws_security_group.example.id]
}


resource "tls_private_key" "sisorg_cluster_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "sisorg_ec2_kp" {
  key_name   = "sisorg_ec2_develop"
  public_key = tls_private_key.sisorg_cluster_pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.sisorg_cluster_pk.private_key_pem}' > ./sisorg_ec2_develop.pem"
  }
}
