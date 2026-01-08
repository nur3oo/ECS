data "aws_ecr_repository" "nur_ecs" {
  name = "nur/ecs"
}



//this is getting the image already inside of my repo calleed nur/ecs with tag latest