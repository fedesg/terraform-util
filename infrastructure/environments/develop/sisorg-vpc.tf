# --- VPC --------------------------------------------------
resource "aws_vpc" "sisorg_vpc" {
  cidr_block = var.cidr_block_vpc

  tags = {
    Name                    = "${var.env_short}-sisorg-vpc"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
  enable_dns_hostnames = true
}

# --- Public --------------------------------------------------
resource "aws_internet_gateway" "sisorg_igw" {
  vpc_id = aws_vpc.sisorg_vpc.id

  tags = {
    Name                    = "${var.env_short}-sisorg-internet-gateway"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_eip" "sisorg_eip_nat" {
  tags = {
    Name                    = "${var.env_short}-sisorg-elastic_ip"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table" "public_routes" {
  vpc_id = aws_vpc.sisorg_vpc.id

  tags = {
    Name                    = "${var.env_short}-sisorg-public-routes"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_routes.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sisorg_igw.id
}

# --- Private  Network --------------------------------------------------
resource "aws_route_table" "private_routes" {
  vpc_id = aws_vpc.sisorg_vpc.id

  tags = {
    Name                    = "${var.env_short}-sisorg-private-routes"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_routes.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.sisorg_nat_gw.id
}
resource "aws_nat_gateway" "sisorg_nat_gw" {
  allocation_id = aws_eip.sisorg_eip_nat.id
  subnet_id     = aws_subnet.sisorg_subnet_1_public.id
  tags = {
    Name                    = "${var.env_short}-sisorg-nat-gateway"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }

}
resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.sisorg_vpc.id
  tags = {
    Name                    = "${var.env_short}-vpc_flow_log"
    "sisorg:service"        = "Logs"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }

}

resource "aws_cloudwatch_log_group" "vpc_flow_log_group" {
  name              = "vpc_flow_log_group_${var.env_tag}"
  retention_in_days = var.log_retention_in_days
  tags = {
    Name                    = "${var.env_short}-vpc_flow_log_group"
    "sisorg:service"        = "Logs"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_iam_role" "flow_log_role" {
  name = "flow_log_role_${var.env_tag}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flow_log_role_policy" {
  name = "flow_log_role_policy_${var.env_tag}"
  role = aws_iam_role.flow_log_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


