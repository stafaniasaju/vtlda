provider "ibm" {
  region = var.region
}

resource "random_string" "random" {
  count = var.prefix == "" ? 1 : 0

  length  = 6
  special = false
}

locals {
  basename = lower(var.prefix == "" ? "simple-da-${random_string.random.0.result}" : var.prefix)
}

resource "ibm_resource_group" "group" {
  name = "${local.basename}-group"
  tags = var.tags
}

resource "ibm_iam_access_group" "administrators" {
  name        = "${local.basename}-administrators"
  description = "Administrators for ${local.basename}"
  tags        = var.tags
}

resource "ibm_iam_access_group" "operators" {
  name        = "${local.basename}-operators"
  description = "Operators for ${local.basename}"
  tags        = var.tags
}

resource "ibm_iam_access_group" "developers" {
  name        = "${local.basename}-developers"
  description = "Developers for ${local.basename}"
  tags        = var.tags
}

resource "ibm_is_vpc" "vpc" {
  resource_group              = ibm_resource_group.group.id
  name                        = "${local.basename}-vpc"
  default_security_group_name = "${local.basename}-sec-group"
  default_network_acl_name    = "${local.basename}-acl-group"
  default_routing_table_name  = "${local.basename}-routing-table"
  tags                        = var.tags
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = ibm_is_vpc.vpc.id
}
