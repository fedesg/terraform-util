# resource "aws_iam_role" "ecsTaskExecutionRole" {
#   name               = "ecsTaskExecutionRole-${var.env_short}"
#   assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json

#   tags = {
#     "sisorg:service"        = "App"
#     "sisorg:environment"    = "${var.env_short}"
#     "sisorg:taggingVersion" = "1.0.0"
#     "sisorg:organization"   = "${var.org_account}"
#     "sisorg:automated"      = "yes"
#   }
# }

# data "aws_iam_policy_document" "ecs_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
#   for_each = toset([
#     "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#   ])

#   role       = aws_iam_role.ecsTaskExecutionRole.name
#   policy_arn = each.value
# }


resource "aws_iam_role" "fargate-task" {
  name               = "fargate-task-${var.env_short}"
  assume_role_policy = data.aws_iam_policy_document.task-role-policy.json

  tags = {
    "kalto:service"        = "App"
    "kalto:environment"    = "${var.env_short}"
    "kalto:taggingVersion" = "1.0.0"
    "kalto:organization"   = "${var.org_account}"
    "kalto:automated"      = "yes"
  }
}

data "aws_iam_policy_document" "task-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "fargate-execution" {
  name               = "fargate-execution-${var.env_short}"
  assume_role_policy = data.aws_iam_policy_document.task-role-policy.json

  tags = {
    "kalto:service"        = "App"
    "kalto:environment"    = var.env_short
    "kalto:taggingVersion" = "1.0.0"
    "kalto:organization"   = var.org_account
    "kalto:automated"      = "yes"
  }
}

# resource "aws_iam_role_policy_attachment" "fargate_execution_ecr_policy" {
#   role       = aws_iam_role.fargate-execution.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ])

  role       = aws_iam_role.fargate-execution.name
  policy_arn = each.value
}