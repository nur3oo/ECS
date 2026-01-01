
terraform {
  backend "s3" {
    bucket = "app-terraform-state1"
    key    = "terraform/terraform.tfstate"
    region = "eu-west-2"
    use_lockfile = true
  }
}

