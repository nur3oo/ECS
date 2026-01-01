variable "vpc_id" {
    type = string
  
}

variable "alb_sg_id" {
    type = string

}

variable "alb_name" {
    type = string  
    default = "node-alb"
}


variable "public_subnets_id" {
    description = "List of the public Subnet IDs for the ALB"
    type = list(string) 
}

variable "matcher" {
    type = string
  
}



variable "load_balancer_type" {
    type = string
}

variable "health_check_path" {
    type = string
    default = "/"
}



variable "private_subnets_id" {
    type = list(string)
  
}

variable "container_port" {
    type = number
  
}


variable "certificate_arn" {
    type = string
  
}

