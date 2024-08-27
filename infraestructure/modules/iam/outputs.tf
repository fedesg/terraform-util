# Outputs the ARN (Amazon Resource Name) of the ECS Task Execution Role.
output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

