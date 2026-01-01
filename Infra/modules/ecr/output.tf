output "repository_url" {
    value = data.aws_ecr_repository.this.repository_url
  
}

output "ecr_image" {
    value = data.aws_ecr_repository.nur_ecs
  
}