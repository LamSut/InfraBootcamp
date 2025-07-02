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
  public_subnet = module.vpc.public_subnet_id
  linux_sg      = module.vpc.linux_sg_id
  windows_sg    = module.vpc.windows_sg_id
}

# output "amazon_mysql_ip" {
#   value = module.ec2.amazon_mysql_public_ip
# }

output "windows_sqlserver_ip" {
  value = module.ec2.windows_sqlserver_public_ip
}
