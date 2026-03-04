resource "aws_ecs_cluster" "ecs" {
  name = var.cluster_name
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_in_days
}



resource "aws_ecs_task_definition" "main" {
  family                   = var.app
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
  {
    name      = var.container_name
    image     = "${var.ecr_repository_url}:${var.image_tag}"
    essential = true

    portMappings = [
      {
        containerPort = 3000
        protocol      = "tcp"
      }
    ]

  
    environment = [
      { name = "NODE_ENV", value = "production" },
      { name = "PORT",     value = "3000" },

      { name = "URL",       value = var.outline_url },
      { name = "REDIS_URL", value = var.redis_url },
    ]
    secrets = [
  { name = "DATABASE_URL", valueFrom = "${var.db_secret_arn}:database_url::" },
  { name = "SECRET_KEY",   valueFrom = "${var.app_secret_arn}:SECRET_KEY::" },
  { name = "UTILS_SECRET", valueFrom = "${var.app_secret_arn}:UTILS_SECRET::" }
]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.this.name
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = var.container_name
      }
    }
  }
])
}

resource "aws_ecs_service" "main" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  force_new_deployment = true

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.containerPort
  }

  health_check_grace_period_seconds = 120
}


