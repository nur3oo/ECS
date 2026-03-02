# trust policy
data "aws_iam_policy_document" "ecs_tasks_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# execution role
resource "aws_iam_role" "ecs_task_execution" {
  name               = "ecs-task-execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume.json
}


# task role (app runtime perms e.g. S3)
resource "aws_iam_role" "ecs_task" {
  name               = "ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume.json
}

resource "aws_iam_role_policy" "ecs_task_s3" {
  name   = "ecs-task-s3"
  role   = aws_iam_role.ecs_task.id
  policy = data.aws_iam_policy_document.task_s3.json
}

# allow execution role to read the RDS secret 
resource "aws_iam_policy" "ecs_read_db_secret" {
  name = "${var.name}-ecs-read-db-secret"
  

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["secretsmanager:GetSecretValue"],
      Resource = [
        "${var.db_secret_arn}*",
        "${var.app_secret_arn}*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secret_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role_policy_attachment" "ecs_exec_read_secrets" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_read_db_secret.arn
}
data "aws_iam_policy_document" "task_s3" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"]
    resources = ["${var.docs_bucket_arn}/uploads/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [var.docs_bucket_arn]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = ["uploads/*"]
    }
  }
}
