output "certificate_arn" {
  description = "Validated ACM certificate ARN (ALB region)"
  value       = aws_acm_certificate_validation.cert.certificate_arn
}
