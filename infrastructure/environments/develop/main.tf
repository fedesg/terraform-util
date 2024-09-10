# module "alb" {
#   source                      = "../../modules/alb"
#   env_short                   = var.env_short
#   org_account                 = var.org_account
#   sisorg_subnet_9_containers  = module.subnets.sisorg_subnet_9_containers.id
#   sisorg_subnet_10_containers = module.subnets.sisorg_subnet_10_containers.id
#   sisorg_sg_internal          = module.subnets.sisorg_sg_internal.id
#   sisorg_sg_stp               = module.subnets.sisorg_sg_stp.id
# }

# module "apigw" {
#   source    = "../../modules/apigw"
#   env_short = var.env_short
# }

# module "cloudwatch" {
#   source    = "../../modules/cloudwatch"
#   env_short = var.env_short
# }

# module "ecs" {
#   source                                       = "../../modules/ecs"
#   env_short                                    = var.env_short
#   org_account                                  = var.org_account
#   env_stop_resources                           = var.env_stop_resources
#   ecs_mixed_cluster_max_instance               = var.ecs_mixed_cluster_max_instance
#   ecs_mixed_cluster_min_instance               = var.ecs_mixed_cluster_min_instance
#   ecs_mixed_cluster_desired_instance           = var.ecs_mixed_cluster_desired_instance
#   ecs_cluster_on_demand_base_capacity          = var.ecs_cluster_on_demand_base_capacity
#   env_on_demand_percentage_above_base_capacity = var.env_on_demand_percentage_above_base_capacity
#   env_ecs_instance                             = var.env_ecs_instance
#   env_stop_resources_cron                      = var.env_stop_resources_cron
#   env_start_resources_cron                     = var.env_start_resources_cron
# }

# module "fargate" {
#   source                                             = "../../modules/fargate"
#   env_short                                          = var.env_short
#   org_account                                        = var.org_account
#   aws_region                                         = var.aws_region
#   log_retention_in_days                              = var.log_retention_in_days
#   template_image_tag                                 = var.template_image_tag
#   env_ecs_service_fargate_tg_type                    = var.env_ecs_service_fargate_tg_type
#   env_template_gin_mode                              = var.env_template_gin_mode
#   env_ecs_task_requires_compatibilities              = var.env_ecs_task_requires_compatibilities
#   env_ecs_service_template_total_mem_hard_limit      = var.env_ecs_service_template_total_mem_hard_limit
#   env_ecs_task_fargate_network_mode                  = var.env_ecs_task_fargate_network_mode
#   env_ecs_service_template_total_cpu_limit           = var.env_ecs_service_template_total_cpu_limit
#   env_ecs_service_template_desired_instance          = var.env_ecs_service_template_desired_instance
#   env_ecs_service_fargate_capacity_provider_template = var.env_ecs_service_fargate_capacity_provider_template
#   env_ecs_service_template_max_instance              = var.env_ecs_service_template_max_instance
#   env_ecs_service_template_min_instance              = var.env_ecs_service_template_min_instance
#   env_stop_resources                                 = var.env_stop_resources
#   env_ecs_task_fargate_autoscale_stop_cron           = var.env_ecs_task_fargate_autoscale_stop_cron
#   env_ecs_task_fargate_autoscale_start_cron          = var.env_ecs_task_fargate_autoscale_start_cron
# }

# module "firewall" {
#   source                     = "../../modules/firewall"
#   env_short                  = var.env_short
#   org_account                = var.org_account
#   vpn_destination_cidr_block = var.vpn_destination_cidr_block
# }

# module "iam" {
#   source      = "../../modules/iam"
#   env_short   = var.env_short
#   org_account = var.org_account
# }

# module "nlb" {
#   source      = "../../modules/nlb"
#   env_short   = var.env_short
#   org_account = var.org_account
# }

# module "roles" {
#   source      = "../../modules/roles"
#   env_short   = var.env_short
#   org_account = var.org_account
# }

# module "route53" {
#   source      = "../../modules/route53"
#   env_short   = var.env_short
#   org_account = var.org_account
# }

module "s3" {
  source      = "../../modules/s3"
  env_short   = var.env_short
  org_account = var.org_account
}

# module "subnets" {
#   source                          = "../../modules/subnets"
#   env_short                       = var.env_short
#   org_account                     = var.org_account
#   region_az1                      = var.region_az1
#   region_az2                      = var.region_az2
#   region_az3                      = var.region_az3
#   cidr_block_subnet_1_public      = var.cidr_block_subnet_1_public
#   cidr_block_subnet_2_public      = var.cidr_block_subnet_2_public
#   cidr_block_subnet_3_cache       = var.cidr_block_subnet_3_cache
#   cidr_block_subnet_4_cache       = var.cidr_block_subnet_4_cache
#   cidr_block_subnet_5_data        = var.cidr_block_subnet_5_data
#   cidr_block_subnet_6_data        = var.cidr_block_subnet_6_data
#   cidr_block_subnet_7_serverless  = var.cidr_block_subnet_7_serverless
#   cidr_block_subnet_8_serverless  = var.cidr_block_subnet_8_serverless
#   cidr_block_subnet_9_containers  = var.cidr_block_subnet_9_containers
#   cidr_block_subnet_10_containers = var.cidr_block_subnet_10_containers
#   cidr_block_subnet_11_containers = var.cidr_block_subnet_11_containers
# }

# module "vpc" {
#   source                = "../../modules/vpc"
#   env_short             = var.env_short
#   org_account           = var.org_account
#   env_tag               = var.env_tag
#   cidr_block_vpc        = var.cidr_block_vpc
#   log_retention_in_days = var.log_retention_in_days
# }

# module "utility" {
#   source                 = "../../modules/utility"
#   env_short              = var.env_short
#   org_account            = var.org_account
#   sisorg_subnet_1_public = aws_route_table_association.subnet_1_public
#   sisorg_sg_utility      = aws_security_group.mcash_sg_utility
#   env_utility_instance   = var.env_utility_instance
#   ami_ubuntu             = var.ami_ubuntu
#   env_tag                = var.env_tag
#   cidr_block_vpc         = var.cidr_block_vpc
# }