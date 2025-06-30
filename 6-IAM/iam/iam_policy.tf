resource "aws_iam_policy" "ec2_instance_full_access" {
  name        = "FullAccessToSpecificEC2"
  description = "Allow full EC2 access to one specific instance"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "ec2:*",
        Resource = [
          "arn:aws:ec2:*:*:instance/${var.ec2_amazon}"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "rds_instance_full_access" {
  name        = "FullAccessToSpecificRDS"
  description = "Allow full RDS access to one specific database"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "rds:*",
        Resource = [
          "arn:aws:rds:*:*:db:${var.rds_mysql}"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "s3_file_read_only" {
  name        = "ReadOnlyS3File"
  description = "Allow to read one file in S3"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["s3:GetObject"],
      Resource = "arn:aws:s3:::${var.s3_static_site}/index.html"
    }]
  })
}
