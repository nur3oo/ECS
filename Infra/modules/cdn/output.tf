output "certificate_arn" {
  description = "Validated ACM certificate ARN in us-east-1 "
  value       = aws_acm_certificate_validation.cd_v.certificate_arn
}

