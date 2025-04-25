module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "igw" {
  source          = "./modules/igw"
  vpc_id          = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
}

module "rds" {
  source          = "./modules/rds"
  db_password     = var.db_password
  private_subnets = module.subnets.private_subnet_ids
  rds_sg_id       = module.security_groups.rds_sg_id
}

module "ec2_instance" {
  source      = "./modules/ec2_instance"
  subnet_id   = module.subnets.public_subnet_ids[0]
  ec2_sg_id   = module.security_groups.ec2_sg_id
  db_endpoint = module.rds.db_endpoint
  db_password = var.db_password
  key_name    = var.key_name
}

module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name
}



