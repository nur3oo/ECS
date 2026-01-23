data "aws_acm_certificate" "alb" {
  domain      = "origin.nur-trade.org"
  statuses    = ["ISSUED"]
  most_recent = true
}