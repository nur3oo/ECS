output "wiki_images_bucket_id" {
  value = aws_s3_bucket.wiki_images.id
}

output "bucket_name" {
  value = aws_s3_bucket.wiki_images.bucket
}

output "docs_bucket_arn" {
  value = aws_s3_bucket.wiki_images.arn
}
