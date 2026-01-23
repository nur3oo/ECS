variable "vpc_id" {
  type = string

}

variable "alb_sg_id" {
  type = string

}

variable "alb_name" {
  type    = string
  default = "node-alb"
}


variable "public_subnets_id" {
  description = "List of the public Subnet IDs for the ALB"
  type        = list(string)
}

variable "matcher" {
  type    = string
  default = "200"

}



variable "load_balancer_type" {
  type    = string
  default = "application"
}

variable "health_check_path" {
  type    = string
  default = "/health"
}


variable "container_port" {
  type    = number
  default = 8080

}

variable "alb_cert_arn" {
  type = string
  
}


