variable "docs_bucket_arn" {
  type = string
}



variable "name" {
  type = string

}

variable "db_secret_arn" {
  type      = string
  sensitive = true

}

variable "app_secret_arn" {
  type = string

}