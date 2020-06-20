resource "aws_elasticache_replication_group" "this" {
  replication_group_id          = var.name
  replication_group_description = var.description
  engine                        = "redis"
  engine_version                = var.engine_version
  node_type                     = var.node_type
  number_cache_clusters         = var.number_nodes
  parameter_group_name          = var.parameter_group_name
  availability_zones            = var.azs
  automatic_failover_enabled    = var.automatic_failover_enabled
  subnet_group_name             = var.subnet_group_name
  security_group_ids            = var.security_groups
  at_rest_encryption_enabled    = true
  maintenance_window            = var.maintenance_window
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit

  lifecycle {
    prevent_destroy = false
  }

  tags = var.tags
}
