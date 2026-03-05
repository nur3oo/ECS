resource "aws_lb" "node_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets_id
}
// alb needs to be in pub sub
resource "aws_lb_target_group" "tg" {
  name        = "${var.alb_name}-tg"
  port        = var.containerPort
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

    health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = var.health_check_path
    matcher             = var.matcher
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "https" {

  load_balancer_arn = aws_lb.node_alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.alb_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
















