provider "aws" {
  region = "eu-west-2"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = var.validation_method



  lifecycle {
    create_before_destroy = true
  }
}




resource "cloudflare_dns_record" "acm_validation" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  ttl     = 60
  type    = "CNAMEs"
  proxied = false
}



resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in cloudflare_dns_record.acm_validation : r.name]
}

