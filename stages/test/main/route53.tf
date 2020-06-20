resource "aws_route53_zone" "mainzone" {
  name = module.stage.domain

  tags = {
    managed_by = "terraform"
  }
}

// private zone
resource "aws_route53_zone" "private" {
  name = "private"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  tags = {
    managed_by = "terraform"
  }
}