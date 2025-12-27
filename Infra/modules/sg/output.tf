output "alb_sg_id" {
    value = aws_security_group.alb_sg.id
    description = "sg ID for my alb"
}

