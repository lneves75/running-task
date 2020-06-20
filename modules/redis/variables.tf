variable "name" {}
variable "description" {}

variable "engine_version" {}

variable "parameter_group_name" {}

variable "node_type" {}

variable "number_nodes" {}

variable "azs" {}

variable "dns_zone_id" {}

variable "automatic_failover_enabled" {
  default = true
}

variable "maintenance_window" {
  default = "wed:15:00-wed:17:00"
}

variable "snapshot_window" {
  default = "07:00-10:00"
}

variable "snapshot_retention_limit" {
  default = 7
}

variable "subnet_group_name" {}

variable "security_groups" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map
  default = {}
}
