# Creates a Virtual Private Cloud (VPC) in AWS with the specified CIDR block.
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block # The IP range for the VPC.
  enable_dns_support   = true           # Enables DNS support in the VPC.
  enable_dns_hostnames = true           # Enables DNS hostnames for instances in the VPC.

  # Tags assigned to the VPC for identification and categorization.
  tags = {
    Name                    = "${var.env_short}-sisorg-vpc" # VPC name, prefixed by the environment short name.
    "sisorg:service"        = "Core"                        # Service category.
    "sisorg:environment"    = "${var.env_short}"            # Environment name (e.g., dev, prod).
    "sisorg:application"    = "Cloud"                       # Application type.
    "sisorg:taggingVersion" = "1.0.0"                       # Version of the tagging standard.
    "sisorg:organization"   = "${var.org_account}"          # AWS organization account.
    "sisorg:automated"      = "yes"                         # Indicates the VPC was created automatically.
  }
}

# Creates public subnets within the VPC.
resource "aws_subnet" "public" {
  count                   = var.public_subnet_count                       # Number of public subnets to create.
  vpc_id                  = aws_vpc.main.id                               # The ID of the VPC to associate with the subnet.
  cidr_block              = element(var.public_subnet_cidrs, count.index) # CIDR block for each subnet.
  map_public_ip_on_launch = true                                          # Automatically assigns a public IP to instances launched in this subnet.
  availability_zone       = element(var.availability_zones, count.index)  # Availability zone for the subnet.
}

# Creates private subnets within the VPC.
resource "aws_subnet" "private" {
  count             = var.private_subnet_count                       # Number of private subnets to create.
  vpc_id            = aws_vpc.main.id                                # The ID of the VPC to associate with the subnet.
  cidr_block        = element(var.private_subnet_cidrs, count.index) # CIDR block for each subnet.
  availability_zone = element(var.availability_zones, count.index)   # Availability zone for the subnet.
}
