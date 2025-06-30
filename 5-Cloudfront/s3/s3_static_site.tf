locals {
  tags = {
    Environment = "dev"
    Project     = "terraform-static-site"
  }

  mime_types = {
    html  = "text/html"
    css   = "text/css"
    ttf   = "font/ttf"
    woff  = "font/woff"
    woff2 = "font/woff2"
    js    = "application/javascript"
    map   = "application/javascript"
    json  = "application/json"
    jpg   = "image/jpeg"
    png   = "image/png"
    svg   = "image/svg+xml"
    eot   = "application/vnd.ms-fontobject"
  }
}

resource "aws_s3_bucket" "static_site" {
  bucket        = "limtruong-static-site"
  force_destroy = true // Allows deletion of bucket with objects (for dev environment)
  tags          = local.tags
}

resource "aws_s3_bucket_public_access_block" "public_static_site" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.static_site.id
  policy = file("${path.module}/s3_static_policy.json")
}

resource "aws_s3_bucket_website_configuration" "static_web_config" {
  bucket = aws_s3_bucket.static_site.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "limweb" {
  for_each     = fileset(path.module, "../limweb/**/*")
  bucket       = aws_s3_bucket.static_site.id
  key          = replace(each.value, "../limweb/", "")
  source       = "${path.module}/${each.value}"
  etag         = filemd5("${path.module}/${each.value}")
  content_type = lookup(local.mime_types, regex("[^.]*$", each.value), "application/octet-stream")
}

data "aws_region" "current" {}

output "static_website_url" {
  description = "URL to access the static website"
  value       = "http://${aws_s3_bucket.static_site.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com"
}

output "static_website_domain" {
  description = "S3 static website endpoint"
  value       = "${aws_s3_bucket.static_site.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com"
}

