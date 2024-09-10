resource "aws_cloudwatch_log_group" "template_loggroup" {
  name              = "template-${var.env_short}"
  retention_in_days = var.log_retention_in_days
  tags = {
    "sisorg:service"        = "Logs"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "template"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_lb_target_group" "template_tg" {
  name                 = "template-tg-${var.env_short}-${substr(uuid(), 0, 3)}"
  port                 = 80
  deregistration_delay = 30
  protocol             = "HTTP"
  vpc_id               = aws_vpc.sisorg_vpc.id
  target_type          = var.env_ecs_service_fargate_tg_type

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 20
    path                = "/health"
    protocol            = "HTTP"
    interval            = 30
    matcher             = "200"
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [name]
  }
  tags = {
    "sisorg:service"        = "App"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "template"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

# ECS
# -----------------------------------------------------------------------------
resource "aws_ecs_task_definition" "client_task" {
  family             = "client-${var.env_short}"
  task_role_arn      = aws_iam_role.fargate-task.arn
  execution_role_arn = aws_iam_role.fargate-execution.arn
  container_definitions = jsonencode([
    {
      name      = "client_task",
      image     = "825765408764.dkr.ecr.us-east-1.amazonaws.com/mc_bank_mock_ms:${var.template_image_tag}",
      essential = true,
      # startTimeout = 300,
      portMappings = [
        {
          hostPort      = 8099,
          protocol      = "tcp",
          containerPort = 8099,
          name          = "client"
        },
      ],
      environment = [
        {
          "name" : "AWS_REGION",
          "value" : var.aws_region
        },
        {
          "name" : "APP_GIN_MODE",
          "value" : var.env_template_gin_mode
        }
      ],
      healthCheck = {
        interval = 120,
        timeout  = 20,
        retries  = 3,
        command = ["CMD-SHELL", "curl -f http://localhost:8099/health || exit 1"]
      },
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group" : aws_cloudwatch_log_group.template_loggroup.name,
          "awslogs-region" : var.aws_region,
          "awslogs-stream-prefix" : "client_task",
          "awslogs-create-group" : "true"
        }
      },
      volumesFrom = [],
      mountPoints = []
    }
  ])
  requires_compatibilities = ["EC2"]
  network_mode = "awsvpc"
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  memory = 512

}

resource "aws_ecs_service" "client" {
  enable_execute_command = true
  name                   = "client-${var.env_short}"
  cluster                = module.ecs_sisorg_cluster.cluster_id
  task_definition        = aws_ecs_task_definition.client_task.arn
  //health_check_grace_period_seconds=var.env_is_live ? 250 : null
  #launch_type     = "FARGATE"
  desired_count          = 1 # Setting the number of containers we want deployed to 3

  capacity_provider_strategy {
    capacity_provider = module.ecs_sisorg_cluster.autoscaling_capacity_providers["capacity-sisorg"].name
    weight            = 1
    base              = 1
  }
  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  deployment_controller {
    type = "ECS"
  }
  lifecycle {
    ignore_changes = [desired_count]
  }
  network_configuration {
    subnets = [aws_subnet.sisorg_subnet_9_containers.id, aws_subnet.sisorg_subnet_10_containers.id]
    security_groups = [aws_security_group.sisorg_sg_internal.id]
  }
  tags = {
    "kalto:service"        = "App"
    "kalto:environment"    = var.env_short
    "kalto:application"    = "client"
    "kalto:taggingVersion" = "1.0.0"
    "kalto:organization"   = var.org_account
    "kalto:automated"      = "yes"
  }
}
