provider "aws" {
    region = var.aws_region
}

provider "cloudflare" {
    api_token = var.cloudflare_api_token
}




resource "aws_acm_certificate" "cert" {
  domain_name       = var.aws_acm_certificate
  validation_method = var.validation_method

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}


