variable "secretsmanager_secret_arns" {
  type    = list(string)
  default = []
}

variable "db_password_secret_arn" {
  type = list(string)
  default = []
}