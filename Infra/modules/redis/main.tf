resource "aws_security_group" "redis" {
  name        = "${var.name}-redis-sg"
  description = "Allow Redis from ECS only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Redis from ECS tasks"
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-redis-sg"
  }
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.name}-redis-subnets"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.name}-redis-subnets"
  }
}


resource "aws_elasticache_replication_group" "this" {
  replication_group_id = "${var.name}-redis"
  description          = "Redis for ${var.name}"

  engine         = "redis"
  engine_version = var.engine_version
  node_type      = var.node_type
  port           = var.port

  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [aws_security_group.redis.id]

  num_cache_clusters         = var.num_cache_clusters
  multi_az_enabled           = var.multi_az_enabled
  automatic_failover_enabled = var.automatic_failover_enabled

  
  at_rest_encryption_enabled = true
  transit_encryption_enabled = false

  tags = {
    Name = "${var.name}-redis"
  }
}