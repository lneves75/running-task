resource "aws_route53_record" "this" {
  zone_id = var.dns_zone_id
  name    = "${var.name}-redis"
  type    = "CNAME"
  ttl     = "3600"
  records = [aws_elasticache_replication_group.this.primary_endpoint_address]
}
