output "security_group_id" {
  value = aws_security_group.redis.id
}

output "primary_endpoint" {
  # For non-cluster mode replication group
  value = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "port" {
  value = var.port
}