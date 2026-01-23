output "alb_cert_arn" {
  value = data.aws_acm_certificate.alb.arn
  description = "the cert for my alb"
  
}