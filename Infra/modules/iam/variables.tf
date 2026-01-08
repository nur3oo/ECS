variable "db_password_secret_arn" {
  type      = string
  sensitive = true

}

variable "docs_bucket_arn" {
  type = string
}