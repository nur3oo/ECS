data "aws_acm_certificate" "alb" {
  domain      = "origin.nur-trade.org"
  types       = ["ISSUED"]
  most_recent = true
}