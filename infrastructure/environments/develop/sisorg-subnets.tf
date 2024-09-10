# ------------------------------------------------------------
resource "aws_subnet" "sisorg_subnet_1_public" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_1_public
  availability_zone       = var.region_az1
  map_public_ip_on_launch = true

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-1-public"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_1_public" {
  subnet_id      = aws_subnet.sisorg_subnet_1_public.id
  route_table_id = aws_route_table.public_routes.id
}

# ------------------------------------------------------------
resource "aws_subnet" "sisorg_subnet_2_public" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_2_public
  availability_zone       = var.region_az2
  map_public_ip_on_launch = true

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-2-public"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_2_public" {
  subnet_id      = aws_subnet.sisorg_subnet_2_public.id
  route_table_id = aws_route_table.public_routes.id
}

# ------------------------------------------------------------
# resource "aws_subnet" "sisorg_subnet_3_cache" {
#   vpc_id                  = aws_vpc.sisorg_vpc.id
#   cidr_block              = var.cidr_block_subnet_3_cache
#   availability_zone       = var.region_az1
#   map_public_ip_on_launch = false

#   tags = {
#     Name                    = "${var.env_short}-sisorg-subnet-3-cache"
#     "sisorg:service"        = "Core"
#     "sisorg:environment"    = var.env_short
#     "sisorg:application"    = "Cloud"
#     "sisorg:taggingVersion" = "1.0.0"
#     "sisorg:organization"   = var.org_account
#     "sisorg:automated"      = "yes"
#   }
# }

# resource "aws_route_table_association" "subnet_3_private" {
#   subnet_id      = aws_subnet.sisorg_subnet_3_cache.id
#   route_table_id = aws_route_table.private_routes.id
# }

# # ------------------------------------------------------------
# resource "aws_subnet" "sisorg_subnet_4_cache" {
#   vpc_id                  = aws_vpc.sisorg_vpc.id
#   cidr_block              = var.cidr_block_subnet_4_cache
#   availability_zone       = var.region_az2
#   map_public_ip_on_launch = false

#   tags = {
#     Name                    = "${var.env_short}-sisorg-subnet-4-cache"
#     "sisorg:service"        = "Core"
#     "sisorg:environment"    = var.env_short
#     "sisorg:application"    = "Cloud"
#     "sisorg:taggingVersion" = "1.0.0"
#     "sisorg:organization"   = var.org_account
#     "sisorg:automated"      = "yes"
#   }
# }

# resource "aws_route_table_association" "subnet_4_private" {
#   subnet_id      = aws_subnet.sisorg_subnet_4_cache.id
#   route_table_id = aws_route_table.private_routes.id
# }

# ------------------------------------------------------------

resource "aws_subnet" "sisorg_subnet_5_data" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_5_data
  availability_zone       = var.region_az1
  map_public_ip_on_launch = false

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-5-data"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_5_private" {
  subnet_id      = aws_subnet.sisorg_subnet_5_data.id
  route_table_id = aws_route_table.private_routes.id
}

# ------------------------------------------------------------

resource "aws_subnet" "sisorg_subnet_6_data" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_6_data
  availability_zone       = var.region_az2
  map_public_ip_on_launch = false

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-6-data"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_6_private" {
  subnet_id      = aws_subnet.sisorg_subnet_6_data.id
  route_table_id = aws_route_table.private_routes.id
}

# ------------------------------------------------------------

resource "aws_subnet" "sisorg_subnet_7_serverless" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_7_serverless
  availability_zone       = var.region_az1
  map_public_ip_on_launch = false

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-7-serverless"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_7_private" {
  subnet_id      = aws_subnet.sisorg_subnet_7_serverless.id
  route_table_id = aws_route_table.private_routes.id
}

# ------------------------------------------------------------

resource "aws_subnet" "sisorg_subnet_8_serverless" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_8_serverless
  availability_zone       = var.region_az2
  map_public_ip_on_launch = false

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-8-serverless"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_8_private" {
  subnet_id      = aws_subnet.sisorg_subnet_8_serverless.id
  route_table_id = aws_route_table.private_routes.id
}

# ------------------------------------------------------------

resource "aws_subnet" "sisorg_subnet_9_containers" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_9_containers
  availability_zone       = var.region_az1
  map_public_ip_on_launch = false

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-9-containers"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_9_private" {
  subnet_id      = aws_subnet.sisorg_subnet_9_containers.id
  route_table_id = aws_route_table.private_routes.id
}

# ------------------------------------------------------------

resource "aws_subnet" "sisorg_subnet_10_containers" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_10_containers
  availability_zone       = var.region_az2
  map_public_ip_on_launch = false

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-10-containers"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_10_private" {
  subnet_id      = aws_subnet.sisorg_subnet_10_containers.id
  route_table_id = aws_route_table.private_routes.id
}

# ------------------------------------------------------------

resource "aws_subnet" "sisorg_subnet_11_containers" {
  vpc_id                  = aws_vpc.sisorg_vpc.id
  cidr_block              = var.cidr_block_subnet_11_containers
  availability_zone       = var.region_az3
  map_public_ip_on_launch = false

  tags = {
    Name                    = "${var.env_short}-sisorg-subnet-11-containers"
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Cloud"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_route_table_association" "subnet_11_private" {
  subnet_id      = aws_subnet.sisorg_subnet_11_containers.id
  route_table_id = aws_route_table.private_routes.id
}

# ------------------------------------------------------------


# resource "aws_db_subnet_group" "sisorg_db_subnet" {
#   name       = "sisorg_db_subnet-${var.env_short}"
#   subnet_ids = [aws_subnet.sisorg_subnet_5_data.id, aws_subnet.sisorg_subnet_6_data.id]
#
#   tags = {
#     Name                    = "${var.env_short}-sisorg-db-subnet"
#     "sisorg:service"        = "Core"
#     "sisorg:environment"    = var.env_short
#     "sisorg:application"    = "Cloud"
#     "sisorg:taggingVersion" = "1.0.0"
#     "sisorg:organization"   = var.org_account
#     "sisorg:automated"      = "yes"
#   }
# }

# resource "aws_elasticache_subnet_group" "sisorg_cache_subnet" {
#   name       = "sisorg-cache-subnet-${var.env_short}"
#   subnet_ids = [aws_subnet.sisorg_subnet_3_cache.id, aws_subnet.sisorg_subnet_4_cache.id]
# }

