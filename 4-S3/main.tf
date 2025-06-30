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

module "s3_static_site" {
  source = "./s3"
}

output "static_website_url" {
  description = "URL to access the static website"
  value       = module.s3_static_site.static_website_url
}
