resource "aws_security_group" "alb_sg" {    //creates the sg
    name        = "${var.name}.sg"
    description = "ALB Security Group"
    vpc_id      = var.vpc_id


ingress {

    description = "http from the internet"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}

egress {

description = "https traffic from the internet" // allows traffic back out through alb on any port
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]

    }

}







  
