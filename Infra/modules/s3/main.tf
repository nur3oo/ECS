resource "aws_s3_bucket" "wiki_images" {
  bucket = "my-wiki-images"
}

//blocks access from pub
resource "aws_s3_bucket_public_access_block" "wiki_images" {

  bucket = var.bucket
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

// ownership of the s3 bucket is enforced to the owner
resource "aws_s3_bucket_ownership_controls" "wiki_images" {
  bucket = aws_s3_bucket.wiki_images.id

  rule {
    object_ownership = "BucketOwnerEnforced"
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



