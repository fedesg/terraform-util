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
variable "aws_region" {}
variable "log_retention_in_days" {}
variable "template_image_tag" {}
variable "env_ecs_service_fargate_tg_type" {}
variable "env_template_gin_mode" {}
variable "env_ecs_task_requires_compatibilities" {}
variable "env_ecs_service_template_total_mem_hard_limit" {}
variable "env_ecs_task_fargate_network_mode" {}
variable "env_ecs_service_template_total_cpu_limit" {}
variable "env_ecs_service_template_desired_instance" {}
variable "env_ecs_service_fargate_capacity_provider_template" {}
variable "env_ecs_service_template_max_instance" {}
variable "env_ecs_service_template_min_instance" {}
variable "env_stop_resources" {}
variable "env_ecs_task_fargate_autoscale_stop_cron" {}
variable "env_ecs_task_fargate_autoscale_start_cron" {}
