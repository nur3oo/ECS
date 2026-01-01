//sg

variable "app_port" {
  type = number
}

variable "egress_port" {
    type = string 
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

variable "alb_http_port" {
    type = number  
}

variable "vpc_id"{
    type = string  
}

variable "alb_https_port" {
    type = string 
}

//vpc

variable "subnet_count" {
    type = string
    default = "2"
  
}

//iam

variable "db_password_secret_arn" {
    type = string
  
}

//alb

variable "load_balancer_type" {
    type = string
}

variable "container_port" {
    type = number
}

variable "interval" {
    type = number 
}

variable "health_check_matcher" {
    type = string
}

variable "alb_name"  {
    type = string
}

variable "target_group_arn" {
    type = string
  
}

variable "matcher"  {
    type = string
}

variable "aws_region" {
    type = string
    default = "eu-west-2"
}

// acm

variable "task_execution_role_arn" {
    type = string  
}

variable "app" {
    type = string
}

variable "retention_in_days" {
    type = string
}

variable "log_group_name" {
    type = string 
}

variable "ecs_cluster" {
    type = string
}

variable "service_name" {
    type = string
}

variable "ecs_security_group_id" {
    type = string
}

variable "container_name" {
    type = string
}

variable "memory" {
    type = string
}

variable "cpu" {
    type = string 
}

variable "execution_role_arn" {
    type = string
}

// s3

variable "bucket" {
    type = string
}

//acm

variable "domain_name" {
    type = string
}
