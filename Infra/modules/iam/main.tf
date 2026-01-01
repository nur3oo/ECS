//created policy trust for iam role
data "aws_iam_policy_document" "ecs_tasks_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
//creates role
resource "aws_iam_role" "ecs_task_execution" {
  name               = "ecs-task-execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume.json
}
//attaching policy
resource "aws_iam_role_policy_attachment" "ecs_exec_attach" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = ""
}
//creates policy docs for secrets
data "aws_iam_policy_document" "ecs_exec_secrets" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [var.db_password_secret_arn]
  }
}

resource "aws_iam_role_policy" "ecs_exec_read_secret" {
  name   = "ecs-exec-read-secret"
  role   = aws_iam_role.ecs_task_execution.name
  policy = data.aws_iam_policy_document.ecs_exec_secrets.json
}

//create the secret

resource "aws_secretsmanager_secret" "db_password" {
  name = "my-db-password"
}


//roles to allow uploads to s3

data "aws_iam_policy_document" "task_s3" {
  statement {
    effect  = "Allow"
    actions = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"]
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

resource "aws_iam_role_policy" "ecs_task_s3" {
  name   = "ecs-task-s3"
  role   = aws_iam_role.ecs_task.id 
  policy = data.aws_iam_policy_document.task_s3.json
}


resource "aws_iam_role" "ecs_task" {
    name = "ecs-task-role"
    assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume.json
  
}