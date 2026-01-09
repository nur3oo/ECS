module "sg" {
  source   = "./modules/sg"
  protocol = var.protocol
  vpc_id   = module.vpc.vpc_id
}

module "vpc" {
  source               = "./modules/vpc"
  subnet_count         = var.subnet_count
  public_subent_cidrs  = var.public_subent_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "iam" {
  source          = "./modules/iam"
  docs_bucket_arn = var.docs_bucket_arn
  secret_name     = var.secret_name
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  certificate_arn    = module.acm.certificate_arn
  load_balancer_type = var.load_balancer_type
  container_port     = var.container_port
  alb_name           = var.alb_name
  alb_sg_id          = module.sg.alb_sg_id
  public_subnets_id  = module.vpc.public_subnet_ids
  matcher            = var.matcher
}

module "ecr" {
  source = "./modules/ecr"

}

module "ecs" {
  source                = "./modules/ecs"
  private_subnet_ids    = module.vpc.private_subnet_ids
  target_group_arn      = module.alb.target_group_arn
  ecr_repository_url    = module.ecr.repository_url
  container_name        = "nur-ecs"
  container_port        = var.container_port
  log_group_name        = var.log_group_name
  cluster_name          = var.cluster_name
  service_name          = var.service_name
  ecs_security_group_id = module.sg.ecs_security_group_id
  task_role_arn         = module.iam.ecs_task_role_arn
  execution_role_arn    = module.iam.ecs_task_execution_role_arn
}

module "s3" {
  source       = "./modules/s3"
  alb_dns_name = module.alb.alb_dns_name
}
module "cdn" {
  source = "./modules/cdn"
}

module "acm" {
  source               = "./modules/acm"
  domain_name          = var.domain_name
  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_zone_id   = var.cloudflare_zone_id
}
