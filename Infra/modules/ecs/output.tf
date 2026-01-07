output "cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.ecs.id
}

output "task_definition_arn" {
  description = "arn of the task definition"
  value       = aws_ecs_task_definition.main.arn
}

output "execution_role_arn" {
  value = aws_ecs_task_definition.main.arn

}