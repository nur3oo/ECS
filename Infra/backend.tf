terraform {
  required_version = ">= 1.14.3, < 2.0.0"

  backend "s3" {
    bucket       = "app-terraform-state1"
    key          = "terraform/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}
