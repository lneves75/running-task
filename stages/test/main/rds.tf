resource "aws_db_subnet_group" "private" {
  name        = "rds-private"
  description = "RDS private subnet group"
  subnet_ids  = module.vpc.private_subnets
}

module "dbcluster" {
  source                  = "../../../modules/rds-cluster"
  name                    = "dbcluster"
  instance_type           = "db.t3.small"
  engine_version          = "5.7.12"
  db_subnet_group_name    = aws_db_subnet_group.private.name
  azs                     = module.stage.azs
  backup_retention_period = 3

  tags = {
    managed_by = "terraform"
    app        = "webshop"
  }
}