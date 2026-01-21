// creating the cert for cloudfront in a seperate module

resource "aws_acm_certificate" "cdn" {
  provider          = aws.use1
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}



resource "cloudflare_dns_record" "cdn_validation" {
  zone_id = var.cloudflare_zone_id

  name    = trimsuffix(tolist(aws_acm_certificate.cdn.domain_validation_options)[0].resource_record_name, ".")
  type    = "CNAME"
  content = trimsuffix(tolist(aws_acm_certificate.cdn.domain_validation_options)[0].resource_record_value, ".")

  ttl     = 60
  proxied = false
}


resource "aws_acm_certificate_validation" "cd_v" {
  provider                = aws.use1
  certificate_arn         = aws_acm_certificate.cdn.arn
  validation_record_fqdns = [cloudflare_dns_record.cdn_validation.name]
}







