// creating the cert for cloudfront in a seperate module

resource "aws_acm_certificate" "cdn" {
    provider = aws.use1
    domain_name = var.domain_name
    validation_method = "DNS"
   
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_acm_certificate_validation" "cd_v" {
    provider = aws.use1
    certificate_arn = aws_acm_certificate.cdn.arn
}


