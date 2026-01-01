output "wiki_images_bucket_id" {
    value = aws_s3_bucket.wiki_images.id 
}

output "bucket_name" {
    value = aws_s3_bucket.wiki_images.bucket  
}

