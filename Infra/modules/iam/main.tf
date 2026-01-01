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



