resource "aws_s3_bucket" "wiki_images" {
  bucket        = "my-wiki-images"
  force_destroy = true
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
    allowed_methods = ["GET", "HEAD", "PUT", "POST"]
    allowed_origins = ["https://${var.app_domain_name}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_cloudfront_origin_access_control" "wiki_images_oac" {
  name                              = "wiki-images-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "wiki_images_cdn" {
  enabled = true

  # ORIGIN 1: App (ALB) — from another module
  origin {
    domain_name = var.alb_dns_name
    origin_id   = "app-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # ORIGIN 2: S3 uploads (private via OAC)
  origin {
    domain_name              = aws_s3_bucket.wiki_images.bucket_regional_domain_name
    origin_id                = "s3-uploads"
    origin_access_control_id = aws_cloudfront_origin_access_control.wiki_images_oac.id
  }

  # Default: your app
  default_cache_behavior {
    target_origin_id       = "app-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = true
      cookies { forward = "all" }
    }
  }

  # /uploads/* from S3
  ordered_cache_behavior {
    path_pattern           = "/uploads/*"
    target_origin_id       = "s3-uploads"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

data "aws_iam_policy_document" "uploads_allow_cf" {
  statement {
    sid    = "AllowCloudFrontReadUploads"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.wiki_images.arn}/uploads/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.wiki_images_cdn.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "uploads" {
  bucket = aws_s3_bucket.wiki_images.id
  policy = data.aws_iam_policy_document.uploads_allow_cf.json
}
