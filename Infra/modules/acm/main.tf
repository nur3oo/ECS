data "aws_acm_certificate" "alb" {
  domain      = "nur-trade.org"
  statuses    = ["ISSUED"]
  most_recent = true
}