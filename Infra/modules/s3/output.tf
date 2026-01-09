output "wiki_images_bucket_id" {
  value = aws_s3_bucket.wiki_images.id
}

output "bucket_name" {
  value = aws_s3_bucket.wiki_images.bucket
}

output "docs_bucket_arn" {
  value = aws_s3_bucket.wiki_images.arn
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.wiki_images_cdn.domain_name
}

output "uploads_bucket_name" {
  value = aws_s3_bucket.wiki_images.bucket
}
