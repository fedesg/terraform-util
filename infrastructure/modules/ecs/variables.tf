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
variable "env_stop_resources" {}
variable "ecs_mixed_cluster_desired_instance" {}
variable "ecs_mixed_cluster_max_instance" {}
variable "ecs_mixed_cluster_min_instance" {}
variable "ecs_cluster_on_demand_base_capacity" {}
variable "env_on_demand_percentage_above_base_capacity" {}
variable "env_ecs_instance" {}
variable "env_start_resources_cron" {}
variable "env_stop_resources_cron" {}
