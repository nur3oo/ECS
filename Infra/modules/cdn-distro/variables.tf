variable "cloudflare_zone_id" {
  type = string
}


variable "acm_cert_arn" {
  type = string  
}

variable "alb_dns_name" {
  type = string
  
}

variable "domain_name" {
  type    = string
  default = "nur-trade.org"
}
