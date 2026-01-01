data "aws_ecr_repository" "nur_ecs" {
  name = "nur/ecs"
}


locals {
  ecs_image = "${data.aws_ecr_repository.nur_ecs.repository_url}:latest"
} 
//this is getting the image already inside of my repo calleed nur/ecs with tag latest