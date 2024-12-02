# Manages S3 lifecycle policies and intelligent tiering configurations

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.storage_bucket.id

  # Rule for avatar_images with immediate transition to Intelligent-Tiering
  rule {
    id     = "avatar_images_lifecycle"
    status = "Enabled"
    filter {
      prefix = "avatar_images/"
    }
    
    transition {
      days          = 0
      storage_class = "INTELLIGENT_TIERING"
    }
  }

  # Rule for student_files with immediate transition to Intelligent-Tiering
  rule {
    id     = "student_files_lifecycle"
    status = "Enabled"
    filter {
      prefix = "student_files/"
    }
    
    transition {
      days          = 0
      storage_class = "INTELLIGENT_TIERING"
    }
  }

  # Cleanup rule for incomplete multipart uploads
  rule {
    id     = "cleanup_failed_uploads"
    status = "Enabled"
    filter {
      prefix = ""
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "intelligent_archive" {
  bucket = aws_s3_bucket.storage_bucket.id
  name   = "archive_configuration"

  # Archive tier for less frequently accessed data
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 90
  }

  # Deep archive tier for rarely accessed data
  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 365
  }
}
