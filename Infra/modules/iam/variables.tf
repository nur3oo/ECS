variable "docs_bucket_arn" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "name" {
  type = string
  
}

variable "db_secret_arn" {
  type = string
  sensitive = true
  
}