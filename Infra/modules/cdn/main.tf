// importing the cloudfront cert here

data "aws_acm_certificate" "cloudfront" {
  provider = aws.use1
  domain   = "nur-trade.org"
  statuses = ["ISSUED"]
  most_recent = true
}






