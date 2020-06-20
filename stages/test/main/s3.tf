resource "aws_s3_bucket" "images" {
  // this name is just to guarantee a unique bucket name for this exercise as S3 buckets need to be unique
  bucket = "myshop-images-b3df23fa552d"
  acl    = "public-read"

  cors_rule {
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    max_age_seconds = 3600
  }
}
