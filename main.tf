module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}


module "alb" {
  source = "./modules/alb"

  lb_name             = var.lb_name
  subnet_ids          = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
  alb_sg_id           = module.sg.alb_sg_id
}

module "ec2" {
  source = "./modules/ec2"

  image_id                 = var.image_id
  instance_type           = var.instance_type
  public_subnet_ids       = module.vpc.public_subnet_ids
  private_subnet_ids      = module.vpc.private_subnet_ids
  target_group_arns_public  = [module.alb.target_group_arn_public]
  target_group_arns_private = [module.alb.target_group_arn_private]
  ec2_public_sg_id 	   = module.sg.ec2_public_sg_id
  ec2_private_sg_id        = module.sg.ec2_private_sg_id
}

module "sg" {
  source    = "./modules/sg"
  vpc_id    = module.vpc.vpc_id
  vpc_cidr  = var.vpc_cidr
  name      = var.name
}


module "rds_postgres" {
  source                   = "./modules/rds"
  name                     = var.name
  username                 = var.username
  password                 = var.password
  db_name                  = var.db_name
  engine                   = var.engine
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  allocated_storage        = var.allocated_storage
  vpc_id                   = module.vpc.vpc_id
  sg_id                    = module.sg.db_sg_id  
  subnet_ids               = module.vpc.private_subnet_ids    

  publicly_accessible      = var.publicly_accessible
  multi_az                 = var.multi_az
  skip_final_snapshot      = var.skip_final_snapshot
  deletion_protection      = var.deletion_protection
  backup_retention_period  = var.backup_retention_period

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  maintenance_window       = var.maintenance_window
}

module "ecr" {
  source = "./modules/ecr"

  repository_name      = var.ecr_repository_name
  scan_on_push         = var.ecr_scan_on_push
  image_tag_mutability = var.ecr_image_tag_mutability
  tags = {
    Environment = var.environment
    Project     = var.project
  }
}


module "secrets" {
  source        = "./modules/secrets"
  secret_name   = var.secret_name
  description   = var.secret_description
  secret_values = var.secret_values
}


module "s3" {
  source                     = "./modules/s3"
  bucket_name                = var.bucket_name
  cloudfront_distribution_id = module.cdn.cloudfront_distribution_id
  iam_user_name              = module.iam_frontend.iam_user_name
  iam_user_arn               = module.iam_frontend.iam_user_arn
  policy_type                = var.policy_type

}

module "cdn" {

  source                      = "./modules/cdn"
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  custom_domain_name          = var.custom_domain_name
  acm_certificate_arn         = var.acm_certificate_arn
}

module "iam_backend" {
  source           = "./modules/iam"
  iam_user_name    = var.iam_user_name_backend
  iam_role_name    = var.iam_role_name_backend
  trusted_services = var.trusted_services

  iam_policies = {
    "jenkins-user-policy"   = "policies/jenkins-user-policy.json",
    "secret-manager-policy" = "policies/secret-manager-policy.json",
    "ecr-read-policy"       = "policies/ecr-read-policy.json"
  }

  user_policy_mapping = {
    "jenkins-user-policy"   = module.ecr.repository_arn 
    "secret-manager-policy" = module.secrets.secret_arn
  }

  role_policy_mapping = {
    "ecr-read-policy"       = module.ecr.repository_arn
  }


  resource_arn_mapping = {
    "jenkins-user-policy"   = module.ecr.repository_arn
    "secret-manager-policy" = module.secrets.secret_arn
    "ecr-read-policy"       = module.ecr.repository_arn
  }
}


module "iam_frontend" {
  source        = "./modules/iam"
  iam_user_name = var.iam_user_name_frontend


  iam_policies = {
    "s3_policy"  = "policies/s3_policy.json",
    "cdn_policy" = "policies/cdn_policy.json",

  }



  user_policy_mapping = {
    "s3_policy"  = module.s3.bucket_arn,
    "cdn_policy" = module.cdn.cdn_arn
  }

  resource_arn_mapping = {
    "s3_policy"  = module.s3.bucket_arn,
    "cdn_policy" = module.cdn.cdn_arn
  }
}
