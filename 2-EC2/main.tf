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

module "ec2" {
  source        = "./ec2"
  public_subnet = module.vpc.public_subnet_ids
  # private_subnet = module.vpc.private_subnet_ids
  security_group = module.vpc.sg_ids
}
