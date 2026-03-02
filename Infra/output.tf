output "cloudfront_domain_name" {
  value = module.cdn-distro.cloudfront_domain_name

}

output "db_secret_arn" {
  value = module.rd.db_secret_arn
  
}