//need this for my alb sg as it will only allow ips from cloudfront to hit the alb, noone can hit tbe alb origin first without cdn
data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"

}

resource "aws_security_group" "alb_sg" { //creates the sg
  name        = "${var.name}.sg"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {

    description = "https traffic from the internet" // allows https to the alb from cloudfront ips only
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront.id]

  }


  egress {

    description = "all traffic out of the ALB"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "ECS" {
  name        = "ECS_SG"
  description = "SG for my ECS"
  vpc_id      = var.vpc_id



  ingress {

    description     = "ALB to the ECS"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]



  }


  egress {
    description = "allow traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]


  }
}

