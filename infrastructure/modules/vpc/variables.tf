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
variable "env_tag" {}
variable "cidr_block_vpc" {}
variable "log_retention_in_days" {}
