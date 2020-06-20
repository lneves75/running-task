terraform {
  backend "s3" {
    bucket         = "terraform-state-test-euw1"
    key            = "main"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
  }
}
