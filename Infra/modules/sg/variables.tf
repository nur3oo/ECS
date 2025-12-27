variable "vpc_id" {
    type = string
  
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "alb"
}

variable "cidr_blocks" {
  type = string
}

variable "protocol" {
    type = string
  
}

variable "to_port" {
    type = string
  
}

variable "from_port" {
  
  type = string
}

variable "egress_port" {
    type = string
  
}


variable "alb_http_port" {
    type = number
  
}

variable "alb_https_port" {
    type = number
  
}

variable "app_port" {
    type = number
  
}