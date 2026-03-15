output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "sg ID for my alb"
}

output "ecs_security_group_id" {
  value = aws_security_group.ECS.id
}

output "cloudfront_prefix_list_id" {
  value = data.aws_ec2_managed_prefix_list.cloudfront.id
  
}

output "cloudfront_prefix_list_arn" {
  value = data.aws_ec2_managed_prefix_list.cloudfront.arn
  
}

output "cloudfront_prefix_list_name" {
  value = data.aws_ec2_managed_prefix_list.cloudfront.name
}