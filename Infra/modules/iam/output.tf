output "db_password_secret_arn" {
  value     = aws_secretsmanager_secret.db_password.arn
  sensitive = true
}

output "ecs_role_arn" {
  description = "ECS task role ARN (used by the app at runtime)"
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_task_execution_arn" {
  description = "ECS task execution role ARN (used by ECS to pull images, logs, secrets)"
  value       = aws_iam_role.ecs_task_execution.arn
}
