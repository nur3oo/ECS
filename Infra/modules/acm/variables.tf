variable "validation_method" {
  type    = string
  default = "DNS"
}


variable "domain_name" {
  type    = string
  default = "nur-trade.org"
}

variable "cloudflare_zone_id" {
  type = string
}

variable "cloudfront_domain_name" {
  type    = string
  default = "d32je5ns14govj.cloudfront.net"
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true

}
