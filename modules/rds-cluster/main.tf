resource "aws_rds_cluster" "this" {
  cluster_identifier              = var.name
  engine                          = "aurora-mysql"
  engine_version                  = var.engine_version
  engine_mode                     = var.engine_mode
  storage_encrypted               = true
  db_subnet_group_name            = var.db_subnet_group_name
  availability_zones              = var.azs
  master_username                 = "root"
  master_password                 = "password"
  db_cluster_parameter_group_name = var.parameter_group_name
  backup_retention_period         = var.backup_retention_period
  skip_final_snapshot = true // This is just for the sake of the exercise and allow tearing down infra

  lifecycle {
    prevent_destroy = false
    ignore_changes  = [master_password]
  }

  tags = var.tags
}

resource "aws_rds_cluster_instance" "this" {
  count                = var.number_nodes
  identifier           = "${var.name}-${count.index}"
  engine                          = "aurora-mysql"
  cluster_identifier   = aws_rds_cluster.this.id
  instance_class       = var.instance_type
  publicly_accessible  = false
  db_subnet_group_name = var.db_subnet_group_name
}
