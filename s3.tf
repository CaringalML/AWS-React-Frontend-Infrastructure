# This file handles all S3-related configurations including bucket creation,
# CORS settings, and folder structure

resource "aws_s3_bucket" "storage_bucket" {
  bucket        = "caringaldevops"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "storage_bucket" {
  bucket = aws_s3_bucket.storage_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "s3_cors" {
  bucket = aws_s3_bucket.storage_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# Create default folders (prefixes) in S3
resource "aws_s3_object" "avatar_images" {
  bucket  = aws_s3_bucket.storage_bucket.id
  key     = "avatar_images/"
  content = ""
}

resource "aws_s3_object" "react_build" {
  bucket  = aws_s3_bucket.storage_bucket.id
  key     = "react-build/"
  content = ""
}

resource "aws_s3_object" "student_files" {
  bucket  = aws_s3_bucket.storage_bucket.id
  key     = "student_files/"
  content = ""
}
