variable "vpc_id" {
  type = string

}

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "alb"
}



variable "protocol" {
  type = string

}

