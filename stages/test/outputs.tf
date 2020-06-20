output "account_id" {
  value = 1234567890
}

output "region" {
  value = "eu-west-1"
}

output "azs" {
  value = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

output "short_region" {
  value = "euw1"
}

output "name" {
  value = "test"
}

output "domain" {
  value = "acme.com"
}

output "vpc_cidr" {
  value = "10.0.0.0/16"
}

output "vpc_public_subnets" {
  value = ["10.0.1.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

output "vpc_private_subnets" {
  value = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
}
