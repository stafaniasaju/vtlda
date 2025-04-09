###############################################################
# Outputs
###############################################################
output "storsight_vsi" {
  description = "A list of VSI with name, id, zone, and primary ipv4 address"
  value       = var.create_storsight_instance ? module.create_storsight_instance.list[0] : []
}

output "powervs_workspace_name" {
  description = "PowerVS infrastructure workspace name."
  value       = local.powervs_workspace_name
}

output "powervs_workspace_guid" {
  description = "PowerVS infrastructure workspace guid. The GUID of the resource instance."
  value       = local.powervs_workspace_guid
}

output "powervs_zone" {
  description = "Zone where PowerVS infrastructure is created."
  value       = local.powervs_zone
}

output "powervs_stor_safe_vtl_instance" {
  description = "All private IPS of FalconStor instance."
  value = {
    crn         = resource.ibm_pi_instance.instance.crn
    instance_id = resource.ibm_pi_instance.instance.instance_id
    powervs_falcon_stor_instance_ips = {
      for entry in resource.ibm_pi_instance.instance.pi_network : "${entry.network_name}_ip" => entry.ip_address
    }
  }
}

output "powervs_stor_safe_vtl_volume_list" {
  description = "All private IPS of FalconStor instance."
  value       = local.powervs_stor_safe_vtl_volume_list
}

output "powervs_management_subnet" {
  description = "Name, ID and CIDR of management private network in created PowerVS infrastructure."
  value       = local.powervs_mgmt_net
}

output "powervs_backup_subnet" {
  description = "Name, ID and CIDR of backup private network in created PowerVS infrastructure."
  value       = local.powervs_bkp_net
}
