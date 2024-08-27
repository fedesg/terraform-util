# Creates an IAM Role for ECS task execution.
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole" # Name of the IAM Role.

  # Specifies the trust relationship policy, allowing ECS tasks to assume this role.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  # Tags assigned to the IAM Role for identification and management.
  tags = {
    "sisorg:service"        = "infra"   # Service category.
    "sisorg:environment"    = "develop" # Environment name.
    "sisorg:application"    = "Entry"   # Application type.
    "sisorg:taggingVersion" = "1.0.0"   # Tagging version.
    "sisorg:organization"   = "develop" # Organization name.
    "sisorg:automated"      = "yes"     # Indicates automation.
  }
}

# Attaches the Amazon ECS Task Execution Role Policy to the IAM Role.
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name                               # The name of the IAM Role to attach the policy to.
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy" # The ARN of the policy.
}
