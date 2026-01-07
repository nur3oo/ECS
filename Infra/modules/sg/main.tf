resource "aws_security_group" "alb_sg" { //creates the sg
  name        = "${var.name}.sg"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id


  ingress {

    description = "http from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = var.protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "https traffic from the internet" // allows https to the alb
    from_port   = 443
    to_port     = 443
    protocol    = var.protocol
    cidr_blocks = ["0.0.0.0/0"]

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
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]



  }


  egress {
    description = "allow traffic to the alb"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]


  }
}

