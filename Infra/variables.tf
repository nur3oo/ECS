//sg

variable "protocol" {
  type    = string
  default = "tcp"
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
  default = 3000
}




variable "alb_name" {
  type    = string
  default = "alb-node"
}


variable "matcher" {
  type    = string
  default = "200"
}

variable "health_check_path" {
  type    = string
  default = "/health"

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
variable "outline_url" {
  type = string

}

variable "container_name" {
  type    = string
  default = "nur-ecs"

}

//acm

variable "domain_name" {
  type    = string
  default = "nur-trade.org"
}



variable "cloudflare_zone_id" {
  type = string
}

//iam



variable "docs_bucket_arn" {
  type    = string
  default = "value"

}


variable "cloudflare_api_token" {
  type      = string
  sensitive = true

}

//rds

variable "name" {
  type    = string
  default = "rds"

}

// redis

variable "project_name" {
  type        = string
  description = "name for all resources"
}

