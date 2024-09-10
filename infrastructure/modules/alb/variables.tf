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

variable "sisorg_subnet_9_containers" {}
variable "sisorg_subnet_10_containers" {}
variable "sisorg_sg_internal" {}
variable "sisorg_sg_stp" {}
