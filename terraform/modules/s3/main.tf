resource "aws_s3_bucket" "this" {
  bucket = "${var.tags["project_name"]}-bucket"

  tags = merge({ name = "OCP-S3-Bucket" }, var.tags)
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}
