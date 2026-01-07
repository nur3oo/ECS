output "acm_validation_records" {
  value = aws_acm_certificate.cert.domain_validation_options
}

output "acm_validation_options" {
  value = aws_acm_certificate.cert.domain_validation_options
}

output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}

