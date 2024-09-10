resource "tls_private_key" "sisorg_utility_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "sisorg_utility_ec2_kp" {
  key_name   = "sisorg_utility_ec2_${var.env_short}"
  public_key = tls_private_key.sisorg_utility_pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.sisorg_utility_pk.private_key_pem}' > ../../files/sisorg_utility_ec2_${var.env_short}.pem"
  }
}
resource "aws_instance" "sisorg_utility" {
  ami                     = var.ami_ubuntu
  instance_type           = var.env_utility_instance
  disable_api_termination = false
  key_name                = aws_key_pair.sisorg_utility_ec2_kp.key_name
  subnet_id               = aws_subnet.sisorg_subnet_1_public.id
  vpc_security_group_ids = [aws_security_group.sisorg_sg_utility.id]


  user_data = base64encode(data.template_file.sisorg_utility_config.rendered)
  root_block_device {
    volume_size = 20
    volume_type = "standard"
  }

  volume_tags = {
    Name        = "${var.env_short}-utility-internal-employee"
    environment = var.env_tag
  }

  tags = {
    Name                    = "${var.env_short}-utility"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Utility"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}

data "template_file" "sisorg_utility_config" {
  template = file("../../templates/utility/utility-config.tpl")
  vars = {
    serverurl      = "vpn-employee-${var.env_short}.sisorg.la"
    peers          = 100
    cidr_block_vpc = var.cidr_block_vpc
  }
}

resource "aws_eip" "sisorg_utility_ip" {
  instance = aws_instance.sisorg_utility.id
  tags = {
    Name                    = "${var.env_short}-utility"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Utility"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}
