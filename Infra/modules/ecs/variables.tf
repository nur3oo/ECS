variable "cluster_name" {
  type = string
}

variable "container_port" {
  type    = number
  default = 3000
}

variable "container_name" {
  type    = string
  default = "nur-ecs"
}

variable "private_subnet_ids" {
  type = list(string)
}


variable "aws_region" {
  type    = string
  default = "eu-west-2"

}


variable "log_group_name" {
  type = string

}

variable "log_retention_in_days" {
  type    = number
  default = 7

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
  type    = string
  default = "v1"

}


variable "app" {
  type    = string
  default = "nur-ecs"
}

variable "service_name" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}


variable "db_secret_arn" {
  type = string

}

variable "app_secret_arn" {
  type = string
}

variable "outline_url" {
  type = string
}


variable "redis_url" {
  type = string
}
