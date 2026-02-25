data "aws_acm_certificate" "alb" {
  domain      = var.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}