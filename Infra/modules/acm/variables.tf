variable "aws_acm_certificate" {
    type = string  
}

variable "validation_method" {
    type = string
    default = "DNS"
}