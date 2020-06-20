resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-state-${module.stage.name}-${module.stage.short_region}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }
}
