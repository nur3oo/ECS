    //Note: Inside another module -
    //module.(module_name).(output_name)
    //inside the module i referenced
    //var.(input_name)

module "alb" {
    source = "./modules/alb"  // sourcing this module to being with

    vpc_id = module.vpc.vpc_id
    alb_sg_id = var.alb_sg_id
    alb_name = var.alb_name
    tg_name = var.tg_name
    https_listener_port = var.https_listener_port

    public_subnet_ids = module.vpc.aws_subnet.public
    private_subnet_ids = module.vpc.aws_subnet.private

    target_group_arn = var.target_group_arn


}