output "s3_log_bucket" {
  description = "Name of the log bucket."
  value       = aws_s3_bucket.log_bucket.id
}
