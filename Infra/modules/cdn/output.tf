output "certificate_arn" {
  value = aws_acm_certificate.cdn.arn
}

output "acm_validation_options" {
  value = aws_acm_certificate.cdn.domain_validation_options
}

output "acm_validation_records" {
  value = aws_acm_certificate.cdn.domain_validation_options
}
