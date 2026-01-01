output "target_group_arn" {
    value = aws_lb_target_group.tg.arn
  
}

output "alb_dns_name" {
  value = aws_lb.node_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.node_alb.zone_id
}



