module "vpc" {
  source = "./modules/vpc"
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "acm" {
  source         = "./modules/acm"
  project_name   = var.project_name
  domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
}

module "alb" {
  source = "./modules/alb"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  container_port    = 8080
  certificate_arn   = module.acm.certificate_arn
}

module "ecs" {
  source = "./modules/ecs"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  alb_target_group_arn  = module.alb.target_group_arn
  alb_security_group_id = module.alb.alb_security_group_id
  container_image       = "${module.ecr.repository_url}:latest"
  container_port        = 8080
}

module "route53" {
  source = "./modules/route53"

  hosted_zone_id = var.hosted_zone_id
  record_name    = var.domain_name
  alb_dns_name   = module.alb.alb_dns_name
  alb_zone_id    = module.alb.alb_zone_id
}