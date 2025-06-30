provider "aws" {
  alias  = "virgin"
  region = "us-east-1"
}

provider "aws" {
  alias  = "ohio"
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket         = "limtruong-bucket"
    key            = "state"
    region         = "us-east-1"
    dynamodb_table = "limtruong-table"
  }
}

module "vpc_a" {
  source = "./vpc_a"
  providers = {
    aws.reg_a = aws.virgin
    aws.reg_b = aws.ohio
  }
}

module "vpc_b" {
  source = "./vpc_b"
  providers = {
    aws.reg_a = aws.virgin
    aws.reg_b = aws.ohio
  }
}

module "vpc_peering" {
  source = "./vpc_peering"
  providers = {
    aws.reg_a = aws.virgin
    aws.reg_b = aws.ohio
  }
  vpc_a_id            = module.vpc_a.vpc_a_id
  vpc_b_id            = module.vpc_b.vpc_b_id
  vpc_a_cidr_block    = module.vpc_a.vpc_a_cidr_block
  vpc_b_cidr_block    = module.vpc_b.vpc_b_cidr_block
  vpc_a_private_rt_id = module.vpc_a.vpc_a_private_rt_id
  vpc_b_private_rt_id = module.vpc_b.vpc_b_private_rt_id
}

module "vpc_sg" {
  source = "./vpc_sg"
  providers = {
    aws.reg_a = aws.virgin
    aws.reg_b = aws.ohio
  }
  vpc_a_id            = module.vpc_a.vpc_a_id
  vpc_b_id            = module.vpc_b.vpc_b_id
  vpc_a_cidr_block    = module.vpc_a.vpc_a_cidr_block
  vpc_b_cidr_block    = module.vpc_b.vpc_b_cidr_block
  vpc_a_private_rt_id = module.vpc_a.vpc_a_private_rt_id
  vpc_b_private_rt_id = module.vpc_b.vpc_b_private_rt_id
}
