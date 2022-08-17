resource "aws_s3_bucket" "this" {
  bucket = "${var.tags["project_name"]}-bucket"

  tags = merge({ name = "OCP-S3-Bucket" }, var.tags)
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.tags["project_name"]}-log-bucket"

  tags = merge({ name = "OCP-S3-Log-Bucket" }, var.tags)
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.this.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}
