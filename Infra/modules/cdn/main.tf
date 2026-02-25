// importing the cloudfront cert here

data "aws_acm_certificate" "cloudfront" {
  provider    = aws.use1
  domain      = var.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}






