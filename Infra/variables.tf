//sg

variable "app_port" {
  type    = number
  default = 8080

}



variable "protocol" {
  type    = string
  default = "tcp"
}



variable "alb_http_port" {
  type    = number
  default = 0

}


//vp
variable "subnet_count" {
  type    = number
  default = 2

}

variable "public_subent_cidrs" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]

}

variable "private_subnet_cidrs" {
  type    = list(any)
  default = ["10.0.5.0/24", "10.0.6.0/24"]

}



//alb

variable "load_balancer_type" {
  type    = string
  default = "application"
}

variable "container_port" {
  type    = number
  default = 8080
}




variable "alb_name" {
  type    = string
  default = "alb-node"
}


variable "matcher" {
  type    = string
  default = "200"
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

//ecr
variable "ecr_image" {
  type = string
}

variable "image_tag" {
  type = string

}

//ecs

variable "log_group_name" {
  type    = string
  default = "This"

}


variable "cluster_name" {
  type    = string
  default = "ecs"
}

variable "service_name" {
  type    = string
  default = "name"

}


variable "container_name" {
  type    = string
  default = "app"
}

variable "memory" {
  type    = number
  default = 512
}

variable "cpu" {
  type    = number
  default = 256
}







//acm

variable "domain_name" {
  type    = string
  default = "nur-trade.org"
}

//iam

variable "db_password_secret_arn" {
  type      = string
  sensitive = true

}

variable "execution_role_arn" {
  type = string

}

variable "docs_bucket_arn" {
  type    = string
  default = "value"

}