# Environment General Variables
# -----------------------------------------------------------------------------
aws_region  = "us-east-1"
region_az1  = "us-east-1b"
region_az2  = "us-east-1c"
region_az3  = "us-east-1b"
env_short   = "dev"
env_tag     = "development"
org_account = "825765408764"
####################################################
############INFRA Instances#########################
ami_ubuntu                                   = "ami-0e86e20dae9224db8" # sisorg Utility Jenkins/VPN - Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
ecs_cluster_ami                              = "ami-0b0d54b52c62864d6" # ECS cluster images
env_db_instance                              = "db.t3.small"
env_db_aurora_instance                       = "db.t3.medium"
env_ecs_instance                             = "t3a.medium"
env_utility_instance                         = "t3a.small"
env_grafana_instance                         = "t3a.small"
env_public_entry_instance                    = "t3a.small"
env_private_entry_instance                   = "t3a.small"
ecs_mixed_cluster_desired_instance           = "0"
ecs_mixed_cluster_max_instance               = "0"
ecs_mixed_cluster_min_instance               = "0"
ecs_cluster_on_demand_base_capacity          = "0"
env_on_demand_percentage_above_base_capacity = "0"
env_ecs_service_fargate_tg_type              = "ip"
env_ecs_task_requires_compatibilities        = "FARGATE"
env_ecs_task_fargate_network_mode            = "awsvpc"
env_ecs_task_fargate_autoscale_stop_cron     = "cron(00 01 ? * * *)"
env_ecs_task_fargate_autoscale_start_cron    = "cron(00 11 ? * MON-SUN *)"
env_stop_resources                           = "true"
env_stop_resources_cron                      = "00 23 * * 1-7"
env_start_resources_cron                     = "00 07 * * 1-7"
env_stop_resources_cron_utc                  = "00 23 ? * * *"
env_start_resources_cron_utc                 = "00 10 ? * MON-SUN *"
####################################################
############INFRA Networking########################
cidr_block_vpc                  = "10.40.0.0/16"
cidr_block_subnet_1_public      = "10.40.0.0/22"
cidr_block_subnet_2_public      = "10.40.4.0/22"
cidr_block_subnet_3_cache       = "10.40.8.0/22"
cidr_block_subnet_4_cache       = "10.40.12.0/22"
cidr_block_subnet_5_data        = "10.40.16.0/22"
cidr_block_subnet_6_data        = "10.40.20.0/22"
cidr_block_subnet_7_serverless  = "10.40.24.0/22"
cidr_block_subnet_8_serverless  = "10.40.28.0/22"
cidr_block_subnet_9_containers  = "10.40.32.0/22"
cidr_block_subnet_10_containers = "10.40.36.0/22"
cidr_block_subnet_11_containers = "10.40.40.0/22"
vpn_destination_cidr_block      = "10.5.1.1/32"
vpn_sisorg_cidr_block           = "52.8.17.212/32"
####################################################
############INFRA Logs##############################
log_retention_in_days        = "1"
lambda_log_retention_in_days = "1"
env_opensearch_url           = "vpc-logs-dev-ts7fuku6yg5pph3p4ekmb5v5qu.us-east-1.es.amazonaws.com"
####################################################
############DocuDB##################################
env_docudb_user                  = "sisorguser"
env_docudb_password              = "adminadmin"
env_docudb_connection            = "arn:aws:ssm:us-east-1:656806665510:parameter/dev_docudb_connection"
env_docudb_bckp_retention_period = 7
env_docudb_instance_size         = 1
env_docudb_instance_type         = "db.t3.medium"
####################################################
############DocuDB##################################
instance_count           = 2
instance_type            = "t3.small.search" //vCPU=2 , Memory(GiB)=2, $0.076(Per hour)
dedicated_master_count   = 3
dedicated_master_enabled = false
dedicated_master_type    = "t3.small.search" //vCPU=2 , Memory(GiB)=2, $0.076(Per hour)
zone_awareness_enabled   = true
####################################################
############Lambdas#################################
authorization_jenkins = "Basic bW92aWxjYXNoOjExMzQxNzc1MzY4OWZhNDc1MTgxYjk0MzdmY2QyMGNmZmY="
data_jenkins          = "{'changeLogFile': 'changelog/db_changelog_master.xml'}"
liquibase_env         = "sisorg-db-pipe"
###################################################
############Common ms ENV###########################
app_profile = "DEVELOP"
###################################################
############Template ENV###############################
template_image_tag                                 = "latest"
env_ecs_service_fargate_capacity_provider_template = "FARGATE_SPOT"
env_ecs_service_template_total_cpu_limit           = 256
env_ecs_service_template_total_mem_hard_limit      = 512
env_ecs_service_template_max_instance              = "1"
env_ecs_service_template_min_instance              = "1"
env_ecs_service_template_desired_instance          = "1"
env_template_gin_mode                              = "release"
###################################################
