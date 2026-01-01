module "sg" {
    source = "./modules/sg"
    app_port        = var.app_port 
    egress_port     =  var.egress_port 
    protocol        = var.protocol
    to_port         = var.to_port
    from_port       = var.from_port
    alb_http_port   = var.alb_http_port
    alb_https_port  = var.alb_https_port
    vpc_id          = var.vpc_id
    cidr_blocks     = var.cidr_blocks
  
}

module "vpc" {
    source           = "./modules/vpc"
    subnet_count     = var.subnet_count
    vpc_cidr         = var.vpc_id
  
}

module "iam" {
    source = "./modules/iam"
    db_password_secret_arn = var.db_password_secret_arn
}


module "alb" {
    source              = "./modules/alb"
    vpc_id              = module.vpc.vpc_id
    certificate_arn     = module.acm.certificate_arn
    load_balancer_type  = var.load_balancer_type
    container_port      = var.container_port
    target_group_arn    = var.target_group_arn
    alb_name            = var.alb_name
    health_check_matcher = var.health_check_matcher
    alb_sg_id           = module.sg.alb_sg_id
    matcher             = var.matcher
    public_subnets_id   = module.vpc.public_subnet_ids
    interval            = var.interval
    private_subnets_id  = module.vpc.private_subnet_ids
}

module "ecr" {
    source              = "./modules/ecr"

}

module "ecs" {
    source              = "./modules/ecs"
    service_name        = var.service_name
    cpu                 = var.cpu
    private_subnet_ids  = module.vpc.private_subnet_ids
    target_group_arn    = module.alb.target_group_arn
    ecr_repository_url  = module.ecr.repository_url
    container_name      = var.container_name
    memory              = var.memory
    app                 = var.app
    container_port      = var.container_port
    ecr_image           = module.ecr.ecr_image
    ecs_security_group_id = var.ecs_security_group_id
    ecs_cluster         = var.ecs_cluster
    log_group_name      = var.log_group_name
    db_password_secret_arn = var.db_password_secret_arn
    retention_in_days   = var.retention_in_days
    execution_role_arn  = var.execution_role_arn
    task_execution_role_arn = module.iam.task_execution_role_arn
}

module "s3" {
    source              = "./modules/s3"
    bucket              = var.bucket
}

module "cdn" {
    source              = "./modules/cdn" 
}

module "acm" {
    source              = "./modules/acm"
    domain_name         = var.domain_name
}