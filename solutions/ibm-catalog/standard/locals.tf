# Extract schematics workspace location
locals {
  schematics_ws_location = regex("^[a-z/-]+", var.prerequisite_workspace_id)
}

# Extract power virtual server workspace data
locals {
  powervs_infrastructure = jsondecode(data.ibm_schematics_output.schematics_output.output_json)
  powervs_workspace_guid = local.powervs_infrastructure[0].powervs_workspace_guid.value
  powervs_workspace_crn  = local.powervs_infrastructure[0].powervs_workspace_id.value
  powervs_workspace_name = local.powervs_infrastructure[0].powervs_workspace_name.value
  powervs_sshkey_name    = local.powervs_infrastructure[0].powervs_ssh_public_key.value.name
  powervs_images         = local.powervs_infrastructure[0].powervs_images.value
  powervs_mgmt_net       = local.powervs_infrastructure[0].powervs_management_subnet.value.name
  powervs_bkp_net        = local.powervs_infrastructure[0].powervs_backup_subnet.value.name
  pi_image_id            = lookup(local.powervs_images, "VTL-FalconStor-11_13_001", null)
}

locals {
  placement_group    = [for x in data.ibm_pi_placement_groups.cloud_instance_groups.placement_groups : x if x.name == var.placement_group]
  placement_group_id = length(local.placement_group) > 0 ? local.placement_group[0].id : ""
}

# Consolidate volume list
locals {
  volume_map = [resource.ibm_pi_volume.configuration_volume, resource.ibm_pi_volume.index_volume, resource.ibm_pi_volume.tape_volume]
  powervs_stor_safe_vtl_volume_list = [
    for volume in local.volume_map : {
      volume_id               = volume.volume_id
      volume_io_throttle_rate = volume.io_throttle_rate
      volume_name             = volume.pi_volume_name
      volume_pool             = volume.pi_volume_pool
      volume_size             = volume.pi_volume_size
      volume_type             = volume.pi_volume_type
      volume_status           = volume.volume_status
      volume_wwn              = volume.wwn
    }
  ]
}
