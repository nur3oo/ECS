terraform {
  required_version = ">= 1.14.3, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.62.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}
