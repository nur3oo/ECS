resource "aws_security_group" "alb_sg" {    //creates the sg
    name        = "${var.name}.sg"
    description = "ALB Security Group"
    vpc_id      = var.vpc_id


ingress {

    description = "http from the internet"
    from_port = var.alb_http_port
    to_port = var.alb_http_port
    protocol = var.protocol
    cidr_blocks =  [var.cidr_blocks]
}

ingress {

  description = "https traffic from the internet" // allows https to the alb
  from_port = var.alb_https_port
  to_port = var.alb_https_port
  protocol = var.protocol
  cidr_blocks = [var.cidr_blocks]

    }







egress {

  description = "all traffic out of the ALB"
  from_port = var.egress_port
  to_port = var.egress_port
  protocol = var.protocol
  cidr_blocks= [var.cidr_blocks]
    }

}


resource "aws_security_group" "ECS" {
  name = "ECS_SG"
  description = "SG for my ECS"
  vpc_id = var.vpc_id
  


ingress {

  description = "ALB to the ECS"
  from_port = var.app_port
  to_port = var.app_port
  protocol = var.protocol
  security_groups = [ aws_security_group.alb_sg.id ]



  }


egress {
  description = "allow traffic from the alb"
  from_port = var.egress_port
  to_port = var.egress_port
  protocol = var.protocol
  cidr_blocks = [var.cidr_blocks]


    }
}
  
