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

# Modules
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

module "s3_static_site" {
  source = "./s3"
}

module "iam" {
  source                  = "./iam"
  ec2_amazon              = module.ec2.ec2_amazon_id
  rds_mysql               = module.rds.mysql_identifier
  s3_static_site          = module.s3_static_site.static_site_bucket_name
  s3_static_public_policy = module.s3_static_site.static_site_public_policy
}

# Outputs
output "amazon_id" {
  description = "EC2 instance ID"
  value       = module.ec2.ec2_amazon_id
}

output "mysql_identifier" {
  description = "RDS MySQL instance identifier"
  value       = module.rds.mysql_identifier
}

output "mysql_connect_cmd" {
  description = "MySQL CLI connection string"
  value       = "mysql -h ${module.rds.mysql_endpoint} -u limtruong -plimkhietngoingoi limdb"
}

output "static_website_url" {
  description = "URL to access the static website"
  value       = module.s3_static_site.static_website_url
}

output "uri_index_file" {
  description = "S3 URI of index.html file"
  value       = module.s3_static_site.s3_uri_index_file
}

output "uri_error_file" {
  description = "S3 URI of error.html file"
  value       = module.s3_static_site.s3_uri_error_file
}
