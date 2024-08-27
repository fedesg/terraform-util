# Defines the subnet ID where the ECS tasks will be launched.
variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

# Specifies the name of the ECS Cluster.
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

# Defines the security group ID associated with the ECS tasks.
variable "security_group_id" {
  description = "The security group ID to associate with the ECS tasks"
  type        = string
}

# Specifies the ARN of the IAM role used by ECS tasks for execution.
variable "ecs_task_exec_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

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
