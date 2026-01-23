output "certificate_arn" {
  description = "Validated ACM certificate ARN in us-east-1 "
  value       = data.aws_acm_certificate.cloudfront.arn
}

