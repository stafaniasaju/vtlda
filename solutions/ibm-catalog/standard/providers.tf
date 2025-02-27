# terraform {
#   required_providers {
#     ibm = {
#       source  = "IBM-Cloud/ibm"
#       version = "= 1.70.1"
#       configuration_aliases = [ibm.ibm-pi]
#     }
#   }
# }

locals {
  ibm_powervs_zone_region_map = {
    "syd04"    = "syd"
    "syd05"    = "syd"
    "sao01"    = "sao"
    "sao04"    = "sao"
    "tor01"    = "tor"
    "mon01"    = "mon"
    "eu-de-1"  = "eu-de"
    "eu-de-2"  = "eu-de"
    "mad02"    = "mad"
    "mad04"    = "mad"
    "lon04"    = "lon"
    "lon06"    = "lon"
    "osa21"    = "osa"
    "tok04"    = "tok"
    "us-south" = "us-south"
    "dal10"    = "us-south"
    "dal12"    = "us-south"
    "dal14"    = "us-south"
    "us-east"  = "us-east"
    "wdc06"    = "us-east"
    "wdc07"    = "us-east"
  }

  pvs_info = split(":", local.powervs_workspace_crn)
  pi_location = local.pvs_info[5]
  pid      = local.pvs_info[7]
}

provider "ibm" { 
  ibmcloud_api_key = var.ibmcloud_api_key
  region = lookup(local.ibm_powervs_zone_region_map, local.pi_location, null)
  zone   = local.pi_location
}

provider "ibm" {
  alias = "ibm_sch"
  ibmcloud_api_key = var.ibmcloud_api_key
  region = lookup(local.ibm_powervs_zone_region_map, local.location, null)
  zone   = local.location
}
