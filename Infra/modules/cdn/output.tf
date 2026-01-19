output "certificate_arn" {
  description = "Validated ACM certificate ARN in us-east-1 (use this in CloudFront viewer_certificate)"
  value       = aws_acm_certificate_validation.cd_v.certificate_arn
}

