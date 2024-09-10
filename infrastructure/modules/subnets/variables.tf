# Environment Configuration
variable "env_short" {
  description = "The environment short name"
  type        = string
}

# Organization and Account Configuration
variable "org_account" {
  description = "The organization account"
  type        = string
}
variable "region_az1" {}
variable "region_az2" {}
variable "region_az3" {}
variable "cidr_block_subnet_1_public" {}
variable "cidr_block_subnet_2_public" {}
variable "cidr_block_subnet_3_cache" {}
variable "cidr_block_subnet_4_cache" {}
variable "cidr_block_subnet_5_data" {}
variable "cidr_block_subnet_6_data" {}
variable "cidr_block_subnet_7_serverless" {}
variable "cidr_block_subnet_8_serverless" {}
variable "cidr_block_subnet_9_containers" {}
variable "cidr_block_subnet_10_containers" {}
variable "cidr_block_subnet_11_containers" {}
