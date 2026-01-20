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
  for_each = {
    for dvo in aws_acm_certificate.cdn.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = var.cloudflare_zone_id
  name    = each.value.name
  type    = each.value.type
  content = each.value.value
  ttl     = 60
  proxied = false
}


resource "aws_acm_certificate_validation" "cd_v" {
  provider                = aws.use1
  certificate_arn         = aws_acm_certificate.cdn.arn
  validation_record_fqdns = [for r in cloudflare_record.cdn_validation : r.hostname]
}






