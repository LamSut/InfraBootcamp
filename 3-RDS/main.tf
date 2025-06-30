provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "limtruong-bucket"
    key            = "state"
    region         = "us-east-1"
    dynamodb_table = "limtruong-table"
  }
}

module "vpc" {
  source = "./vpc"
}

module "rds" {
  source           = "./rds"
  vpc_id           = module.vpc.vpc_id
  private_subnet_1 = module.vpc.private_subnet_1_id
  private_subnet_2 = module.vpc.private_subnet_2_id
  security_group   = module.vpc.rds_sg_id
}

module "ec2" {
  source         = "./ec2"
  public_subnet  = module.vpc.public_subnet_id
  security_group = module.vpc.ec2_sg_id
  mysql_endpoint = module.rds.mysql_endpoint
}

output "mysql_connect_cmd" {
  description = "MySQL CLI connection string"
  value       = "mysql -h ${module.rds.mysql_endpoint} -u limtruong -plimkhietngoingoi limdb"
}
