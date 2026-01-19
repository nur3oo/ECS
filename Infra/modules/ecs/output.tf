output "cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.ecs.id
}

output "task_definition_arn" {
  description = "arn of the task definition"
  value       = aws_ecs_task_definition.main.arn
}


output "ecs_execution_role_arn" {
  description = "Execution role ARN used by the task definition"
  value       = var.execution_role_arn
}

output "ecs_task_role_arn" {
  description = "Task role ARN used by the task definition"
  value       = var.task_role_arn
}
