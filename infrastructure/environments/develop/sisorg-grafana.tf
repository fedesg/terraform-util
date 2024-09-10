resource "tls_private_key" "sisorg_grafana_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "sisorg_grafana_ec2_kp" {
  key_name   = "sisorg_grafana_ec2_${var.env_short}"
  public_key = tls_private_key.sisorg_grafana_pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.sisorg_grafana_pk.private_key_pem}' > ../../files/sisorg_grafana_ec2_${var.env_short}.pem"
  }
}
resource "aws_instance" "sisorg_grafana" {
  ami                     = var.ami_ubuntu
  instance_type           = var.env_grafana_instance
  disable_api_termination = false
  key_name                = aws_key_pair.sisorg_grafana_ec2_kp.key_name
  subnet_id               = aws_subnet.sisorg_subnet_1_public.id
  vpc_security_group_ids = [aws_security_group.sisorg_sg_grafana.id]

  user_data = base64encode(data.template_file.sisorg_grafana_config.rendered)
  root_block_device {
    volume_size = 20
    volume_type = "standard"
  }

  volume_tags = {
    Name        = "${var.env_short}-grafana-internal-employee"
    environment = var.env_tag
  }

  tags = {
    Name                    = "${var.env_short}-grafana"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "grafana"
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

data "template_file" "sisorg_grafana_config" {
  template = file("../../templates/Grafana/grafana-config.tpl")
  vars = {
    serverurl      = "vpn-employee-${var.env_short}.sisorg.la"
    cidr_block_vpc = var.cidr_block_vpc
  }
}

resource "aws_eip" "sisorg_grafana_ip" {
  instance = aws_instance.sisorg_grafana.id
  tags = {
    Name                    = "${var.env_short}-grafana"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "grafana"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}