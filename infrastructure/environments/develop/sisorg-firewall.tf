resource "aws_security_group" "sisorg_sg_internal" {
  name        = "sg_internal_${var.env_short}"
  description = "Allow traffic inside the VPC sisorg"
  vpc_id      = aws_vpc.sisorg_vpc.id
  tags = {
    "Name"                  = "sg_internal_${var.env_short}"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Security"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [aws_vpc.sisorg_vpc.cidr_block]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  timeouts {
    create = "45m"
    delete = "45m"
  }
}

resource "aws_security_group" "sisorg_sg_stp" {
  name        = "sg_stp_${var.env_short}"
  description = "Allow traffic from STP"
  vpc_id      = aws_vpc.sisorg_vpc.id
  tags = {
    "Name"                  = "sg_stp_${var.env_short}"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Security"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpn_destination_cidr_block]
    description = "http traffic"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_destination_cidr_block]
    description = "https traffic"
  }
  timeouts {
    create = "45m"
    delete = "45m"
  }
}

resource "aws_security_group" "sisorg_sg_utility" {
  name        = "sg_utility_${var.env_short}"
  description = "Allow traffic from World to jenkins and vpn"
  vpc_id      = aws_vpc.sisorg_vpc.id
  tags = {
    "Name"                     = "sg_utility_${var.env_short}"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Security"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_vpc]
    description = "Jenkins port"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpn_sisorg_cidr_block]
    description = "Sisorg VPN"
  }
  ingress {
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Only VPN port to connect with wireguard"
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  timeouts {
    create = "45m"
    delete = "45m"
  }

}

resource "aws_security_group" "sisorg_sg_grafana" {
  name        = "sg_grafana_${var.env_short}"
  description = "Allow traffic from World to grafana"
  vpc_id      = aws_vpc.sisorg_vpc.id
  tags = {
    "Name"                     = "sg_grafana_${var.env_short}"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Security"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_vpc]
    description = "Grafana port"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_vpc]
    description = "Grafana port from ssh"
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  timeouts {
    create = "45m"
    delete = "45m"
  }
}
