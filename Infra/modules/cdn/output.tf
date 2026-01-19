output "certificate_arn" {
  description = "Validated ACM certificate ARN in us-east-1 (use this in CloudFront viewer_certificate)"
  value       = aws_acm_certificate_validation.cd_v.certificate_arn
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name (dxxxx.cloudfront.net) for DNS"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.this.id
}
