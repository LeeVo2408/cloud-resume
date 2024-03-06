resource "aws_s3_bucket" "cloud_resume_site_bucket" {
  bucket = "tf-aws-lilyvo-cloud-resume-challenge-${var.environment}-site"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloud_resume_site_bucket" {
  bucket = aws_s3_bucket.cloud_resume_site_bucket.id

  rule {
    bucket_key_enabled = true
    
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "cloud_resume_site_bucket" {
  bucket = aws_s3_bucket.cloud_resume_site_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.cloud_resume_site_bucket.id
  key    = "index.html"
  source = "src/index.html"
  etag = filemd5("src/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.cloud_resume_site_bucket.id
  key    = "error.html"
  source = "src/error.html"
  etag = filemd5("src/error.html")
  content_type = "text/html"
}



//logging bucket: to keep track on evert changes 

#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket" "cloud_resume_logging_bucket" {
  bucket = "tf-aws-mgrassi-cloud-resume-challenge-${var.environment}-logging"
}

resource "aws_s3_bucket_versioning" "cloud_resume_logging_bucket" {
  bucket = aws_s3_bucket.cloud_resume_logging_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloud_resume_logging_bucket" {
  bucket = aws_s3_bucket.cloud_resume_logging_bucket.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "cloud_resume_logging_bucket" {
  bucket = aws_s3_bucket.cloud_resume_logging_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "cloud_resume_logging_bucket" {
  bucket = aws_s3_bucket.cloud_resume_logging_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "cloud_resume_logging_bucket" {
  bucket = aws_s3_bucket.cloud_resume_logging_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "cloud_resume_logging_bucket" {
  bucket = aws_s3_bucket.cloud_resume_site_bucket.id

  target_bucket = aws_s3_bucket.cloud_resume_logging_bucket.id
  target_prefix = "log/"
}