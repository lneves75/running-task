resource "aws_elasticache_subnet_group" "private" {
  name       = "redis-private"
  subnet_ids = module.vpc.private_subnets
}

module "redis01" {
  source               = "../../../modules/redis"
  name                 = "webshop"
  description          = "caching layer for webshop orders"
  engine_version       = "5.0.6"
  parameter_group_name = "default.redis5.0"
  node_type            = "cache.t3.medium"
  number_nodes         = 3
  azs                  = module.stage.azs
  dns_zone_id          = aws_route53_zone.private.id
  subnet_group_name    = aws_elasticache_subnet_group.private.name

  tags = {
    managed_by = "terraform"
    app        = "webshop"
  }
}