provider "aws" {
  region = module.stage.region

  allowed_account_ids = [
    module.stage.account_id,
  ]
}
