resource "aws_lb" "node_alb" {
    name               = "node_alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = 
    subnets            = 
}

resource "aws_lb_target_group" "node_alb_tg" {
    name            = "node_alb_tg"
    port            = 8080
    protocol        = "HTTP"
    vpc_id          =
    target_type     = "ip"

     health_check {
    path                = "/health"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
 
}

resource "aws_lb_listener" "http" {
    load_balancer_arn           = 
    port                        = 80
    protocol                    = "HTTP"

}




