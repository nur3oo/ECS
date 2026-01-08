variable "cluster_name" {
  type = string
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "container_name" {
  type    = string
  default = "ecs"
}

variable "private_subnet_ids" {
  type = list(string)
}


variable "aws_region" {
  type    = string
  default = "eu-west-1"

}


variable "log_group_name" {
  type = string

}

variable "log_retention_in_days" {
  type    = number
  default = 7

}

variable "task_execution_role_arn" {
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
  type    = string
  default = "latest"

}


variable "execution_role_arn" {
  type = string

}

variable "app" {
  type    = string
  default = "nur-ecs"
}

variable "service_name" {
  type = string
}

