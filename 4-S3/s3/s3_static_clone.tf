resource "aws_s3_bucket" "static_site_clone" {
  bucket        = "limtruong-static-site-clone"
  force_destroy = true
  tags          = local.tags
}

resource "aws_s3_bucket_public_access_block" "public_static_site_clone" {
  bucket                  = aws_s3_bucket.static_site_clone.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_site_clone_policy" {
  bucket = aws_s3_bucket.static_site_clone.id
  policy = file("${path.module}/s3_static_policy_clone.json")
}

resource "aws_s3_bucket_website_configuration" "static_web_config_clone" {
  bucket = aws_s3_bucket.static_site_clone.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
