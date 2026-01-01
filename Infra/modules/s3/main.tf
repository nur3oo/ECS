resource "aws_s3_bucket" "wiki_images" {
  bucket = "my-wiki-images"
}

resource "aws_s3_bucket_public_access_block" "wiki_images" {
  bucket                  = aws_s3_bucket.wiki_images.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "wiki_images" {
  bucket = aws_s3_bucket.wiki_images.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "wiki_images" {
  bucket = aws_s3_bucket.wiki_images.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "wiki_images" {
  bucket = aws_s3_bucket.wiki_images.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET", "HEAD"]
    allowed_origins = [
      "https://nur-trade.org"
      
    ]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}




// add rules for cloudfront

resource "aws_cloudfront_origin_access_control" "wiki_images_oac" {

    name = "wiki-images-oac"
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"

}
//oac naming what resource this is for
// cloudfront signs request for the s3 for verification
// s3 uses this for verification

//dynamodb



