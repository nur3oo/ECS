resource "aws_ecs_cluster" "ecs" {
  name = var.cluster_name
  # creating the cluster
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_in_days
  # container logs
}


resource "aws_ecs_task_definition" "main" {
  family                   = var.app
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${var.ecr_repository_url}:${var.image_tag}"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]


      environment = [
        { name = "DB_HOST", value = var.db_endpoint },
        { name = "DB_PORT", value = "5432" }
      ]

      secrets = [
        {
          name      = "DB_SECRET_JSON"
          valueFrom = var.db_secret_arn
        }
      ]

     
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.this.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = var.container_name
          "awslogs-create-group"  = "true"
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
  # actually runs the task attaching the sgs and priv subnets

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  health_check_grace_period_seconds = 30
  // health check period for alb
}
