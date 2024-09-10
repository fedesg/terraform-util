# Environment General Variables
# -----------------------------------------------------------------------------
variable "aws_region" {}
output "aws_region" {
  value = var.aws_region
}
variable "region_az1" {}
variable "region_az2" {}
variable "region_az3" {}
variable "env_tag" {}
output "env_tag" {
  value = var.env_tag
}
variable "env_short" {}
variable "org_account" {}
output "org_account" {
  value = var.org_account
}
############INFRA Instances########################-----------------------------
variable "ami_ubuntu" {}
variable "ecs_cluster_ami" {}
variable "env_db_instance" {}
variable "env_db_aurora_instance" {}
variable "env_ecs_instance" {}
variable "env_utility_instance" {}
variable "env_grafana_instance" {}
variable "env_public_entry_instance" {}
variable "env_private_entry_instance" {}
variable "ecs_mixed_cluster_desired_instance" {}
variable "ecs_mixed_cluster_max_instance" {}
variable "ecs_mixed_cluster_min_instance" {}
variable "ecs_cluster_on_demand_base_capacity" {}
variable "env_on_demand_percentage_above_base_capacity" {}
variable "env_ecs_service_fargate_tg_type" {}
variable "env_ecs_task_requires_compatibilities" {}
variable "env_ecs_task_fargate_network_mode" {}
variable "env_ecs_task_fargate_autoscale_stop_cron" {}
variable "env_ecs_task_fargate_autoscale_start_cron" {}
variable "env_stop_resources" {}
variable "env_start_resources_cron" {}
variable "env_stop_resources_cron" {}
variable "env_start_resources_cron_utc" {}
variable "env_stop_resources_cron_utc" {}
variable "create_iam_service_linked_role" {
  type        = string
  default     = "false"
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}
variable "env_opensearch_url" {}
###################################################
############INFRA Networking#######################-----------------------------
variable "cidr_block_vpc" {}
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
variable "vpn_destination_cidr_block" {}
variable "vpn_sisorg_cidr_block" {}
###################################################
############INFRA Logs#############################-----------------------------
variable "log_retention_in_days" {}
variable "lambda_log_retention_in_days" {}
###################################################
############DocumentDB#############################-----------------------------
variable "env_docudb_user" {}
variable "env_docudb_password" {}
variable "env_docudb_connection" {}
variable "env_docudb_bckp_retention_period" {}
variable "env_docudb_instance_type" {}
variable "env_docudb_instance_size" {}
###################################################
############OpenSearch#############################-----------------------------
variable "instance_count" {}
variable "instance_type" {}
variable "dedicated_master_count" {}
variable "dedicated_master_enabled" {}
variable "dedicated_master_type" {}
variable "zone_awareness_enabled" {}
###################################################
############Lambdas#############################-----------------------------
variable "authorization_jenkins" {}
variable "data_jenkins" {}
variable "liquibase_env" {}
###################################################
############Common ms ENV##########################-----------------------------
variable "app_profile" {}
output "app_profile" {
  value = var.app_profile
}
###################################################
############Template ENV###############################-----------------------------
variable "template_image_tag" {}
output "template_image_tag" {
  value = var.template_image_tag
}
variable "env_ecs_service_fargate_capacity_provider_template" {}
variable "env_ecs_service_template_total_cpu_limit" {}
variable "env_ecs_service_template_total_mem_hard_limit" {}
variable "env_ecs_service_template_max_instance" {}
variable "env_ecs_service_template_min_instance" {}
variable "env_ecs_service_template_desired_instance" {}
variable "env_template_gin_mode" {}
###################################################
