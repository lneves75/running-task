variable "name" {}

variable "instance_type" {}

variable "engine_mode" {
  description = "Can be multimaster, parallelquery, provisioned, serverless"
  default     = "provisioned"
}

variable "engine_version" {}

variable "number_nodes" {
  default = 2
}

variable "azs" {}

variable "db_subnet_group_name" {}

variable "parameter_group_name" {
  default = "default.aurora-mysql5.7"
}

variable "backup_retention_period" {
  default = 7
}

variable "monitoring_interval" {
  default = 0
}

variable "tags" {
  type    = map
  default = {}
}
