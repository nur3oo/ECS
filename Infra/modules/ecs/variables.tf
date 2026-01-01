variable "ecs_cluster" {
    type = string
  
}

variable "app" {
    type = string
  
}


variable "container_port" {
    type = string
}

variable "container_name" {
    type = string
    default = "ecs"
}

variable "ecr_image" {
    type = string
}

variable "private_subnet_ids" {
    type = list(string)
}

variable "service_name" {
    type = string
}

variable "aws_region" {
    type = string
    default = "eu-west-1"
  
}


variable "log_group_name" {
    type = string
  
}

variable "retention_in_days" {
    type = number
  
}

variable "task_execution_role_arn" {
  type        = string
}

variable "cpu" {
    type = string
}

variable "memory" {
    type = string
  
}

variable "ecs_security_group_id" {
    type = string
  
}

variable "target_group_arn" {
    type = string
  
}

variable "ecr_repository_url" {
    type = string
  
}

variable "image_tag" {
    type = string
    default = "latest"
  
}

variable "db_password_secret_arn" {
  type = string
}

variable "execution_role_arn" {
    type = string
  
}