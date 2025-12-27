variable "aws_acm_certificate" {
    type = string  
}

variable "validation_method" {
    type = string
    default = "DNS"
}

variable "aws_region" {
    type = string
    default = "eu-west-2"

}

variable "cloudflare_api_token" {
  type = string
  sensitive = true
}

