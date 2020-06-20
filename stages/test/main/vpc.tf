module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.39.0"

  name = module.stage.name

  azs             = module.stage.azs
  cidr            = module.stage.vpc_cidr
  private_subnets = module.stage.vpc_private_subnets
  public_subnets  = module.stage.vpc_public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    managed_by  = "terraform"
    environment = module.stage.name
  }
}