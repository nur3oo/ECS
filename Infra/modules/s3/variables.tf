variable "alb_dns_name" {
  type        = string
  description = "ALB DNS name to use as CloudFront origin for the app"
}

variable "app_domain_name" {
  type        = string
  description = "Your website domain "
  default     = "nur-trade.org"
}
