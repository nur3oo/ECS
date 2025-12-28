variable "vpc_id" {
    type = string

}

variable "alb_sg_id" {
    type = string

}

variable "alb_name" {
    type = string  
}


variable "public_subnets_id" {
    description = "List of the public Subnet IDs for the ALB"
    type = list(string) 
}

variable "matcher" {
    type = string
}

variable "interval" {
    type = number
}


variable "load_balancer_type" {
    type = string
}

variable "health_check_path" {
    type = string
    default = "/"
}

variable "health_check_matcher" {
    type = string
}

variable "private_subnets_id" {
    type = string
  
}

variable "container_port" {
    type = number
  
}


variable "certificate_arn" {
    type = string
  
}

variable "target_group_arn" {
    type = string
  
}
