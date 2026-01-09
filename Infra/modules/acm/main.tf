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

resource "cloudflare_record" "apex" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "CNAME"
  value   = var.cloudfront_domain_name
  ttl     = 60
  proxied = false
}




