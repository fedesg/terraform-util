# Creates an ECS Cluster with the specified name and tags.
resource "aws_ecs_cluster" "sisorg_cluster" {
  name = var.ecs_cluster_name # Name of the ECS Cluster.

  # Tags assigned to the ECS Cluster for identification and management.
  tags = {
    "movilcash:service"        = "Core"          # Service category.
    "movilcash:environment"    = var.env_short   # Environment name.
    "movilcash:application"    = "ECS"           # Application type.
    "movilcash:taggingVersion" = "1.0.0"         # Tagging version.
    "movilcash:organization"   = var.org_account # Organization account.
    "movilcash:automated"      = "yes"           # Indicates automation.
  }
}

# Defines an ECS Task Definition for the ECS Cluster.
resource "aws_ecs_task_definition" "main_task" {
  family             = "example-task"             # Family name of the task definition.
  network_mode       = "awsvpc"                   # Network mode set to AWSVPC for ENI trunking.
  execution_role_arn = var.ecs_task_exec_role_arn # IAM role ARN for task execution.
  task_role_arn      = var.ecs_task_exec_role_arn # IAM role ARN for the task.

  # Container definitions for the task.
  container_definitions = <<DEFINITION
[
  {
    "name": "my-container",
    "image": "nginx",
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION

  requires_compatibilities = ["EC2"] # Specifies that the task will run on EC2 instances.
  cpu                      = "256"   # CPU units for the task.
  memory                   = "512"   # Memory for the task.
}

# Creates an ECS Service to manage tasks in the cluster.
resource "aws_ecs_service" "example_service" {
  name            = "example-service"                     # Name of the ECS Service.
  cluster         = aws_ecs_cluster.sisorg_cluster.id     # ECS Cluster to deploy the service in.
  task_definition = aws_ecs_task_definition.main_task.arn # Task definition to use for the service.
  desired_count   = 2                                     # Number of tasks to run.

  # Configures network settings for the ECS tasks.
  network_configuration {
    subnets         = [var.subnet_id]         # Subnet IDs where the tasks will be launched.
    security_groups = [var.security_group_id] # Security group IDs associated with the tasks.
  }

  launch_type = "EC2" # Launch type set to EC2, which supports ENI trunking.
}

