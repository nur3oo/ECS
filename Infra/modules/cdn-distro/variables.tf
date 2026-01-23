variable "cloudflare_zone_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "alb_dns_name" {
  type = string

}

variable "aliases" {
  type    = list(string)
  default = ["nur-trade.org", "www.nur-trade.org "]
}

variable "cloudflare_api_token" {
  type = string

}
