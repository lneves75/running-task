resource "aws_iam_role" "image_service" {
  name               = "images-service"
  assume_role_policy = data.aws_iam_policy_document.image_service_sts.json
}

data "aws_iam_policy_document" "image_service_sts" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "image_service" {
  name   = "images-service"
  role   = aws_iam_role.image_service.name
  policy = data.aws_iam_policy_document.images_bucket.json
}

data "aws_iam_policy_document" "images_bucket" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = ["${aws_s3_bucket.images.arn}"]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject",
    ]

    resources = ["${aws_s3_bucket.images.arn}/*"]
  }
}