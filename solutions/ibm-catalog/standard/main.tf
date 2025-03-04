###############################################################
# Data from the pre-requisite PowerVS deployable architecture
###############################################################
data "ibm_schematics_workspace" "schematics_workspace" {
  provider     = ibm.ibm_sch
  workspace_id = var.prerequisite_workspace_id
  location     = local.schematics_ws_location
}

data "ibm_schematics_output" "schematics_output" {
  provider     = ibm.ibm_sch
  workspace_id = var.prerequisite_workspace_id
  location     = local.schematics_ws_location
  template_id  = data.ibm_schematics_workspace.schematics_workspace.runtime_data[0].id
}

###############################################################
# Data for Virtual Appliance Instance and Volumes creation
###############################################################
data "ibm_pi_placement_groups" "cloud_instance_groups" {
  pi_cloud_instance_id = local.powervs_workspace_guid
}
data "ibm_pi_key" "key" {
  pi_cloud_instance_id = local.powervs_workspace_guid
  pi_key_name          = local.powervs_sshkey_name
}
data "ibm_pi_network" "powervs_management_subnet" {
  pi_cloud_instance_id = local.powervs_workspace_guid
  pi_network_name      = local.powervs_mgmt_net
}
data "ibm_pi_network" "powervs_backup_subnet" {
  pi_cloud_instance_id = local.powervs_workspace_guid
  pi_network_name      = local.powervs_bkp_net
}
data "ibm_pi_network" "network_3" {
  count                = length(var.network_3) > 0 ? 1 : 0
  pi_cloud_instance_id = local.powervs_workspace_guid
  pi_network_name      = var.network_3
}

###############################################################
# Deploy Virtual Appliance Instance and Volumes
###############################################################
resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id           = local.powervs_workspace_guid
  pi_memory                      = var.memory
  pi_processors                  = var.vcpus
  pi_instance_name               = var.instance_name
  pi_proc_type                   = var.processor_mode
  pi_image_id                    = local.pi_image_id
  pi_sys_type                    = var.system_type
  pi_storage_type                = var.storage_type
  pi_key_pair_name               = length(local.powervs_sshkey_name) > 0 ? data.ibm_pi_key.key.id : null
  pi_affinity_policy             = length(var.pvm_instances) > 0 ? var.policy_affinity : null
  pi_anti_affinity_instances     = length(var.pvm_instances) > 0 ? split(",", var.pvm_instances) : null
  pi_placement_group_id          = local.placement_group_id
  pi_license_repository_capacity = var.repository_capacity # deprecated
  pi_network {
    network_id = data.ibm_pi_network.powervs_management_subnet.id
    ip_address = length(var.management_net_ip) > 0 ? var.management_net_ip : ""
  }
  dynamic "pi_network" {
    for_each = local.powervs_bkp_net == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.powervs_backup_subnet.id
      ip_address = length(var.backup_net_ip) > 0 ? var.backup_net_ip : ""
    }
  }
  dynamic "pi_network" {
    for_each = var.network_3 == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_3[0].id
      ip_address = length(var.network_3_ip) > 0 ? var.network_3_ip : ""
    }
  }
}

resource "ibm_pi_volume" "configuration_volume" {
  pi_volume_size       = var.volume_configuration_size
  pi_volume_name       = "${var.instance_name}_configuration-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.powervs_workspace_guid
}

resource "ibm_pi_volume" "index_volume" {
  pi_volume_size       = var.volume_index_size
  pi_volume_name       = "${var.instance_name}_index-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.powervs_workspace_guid
}

resource "ibm_pi_volume" "tape_volume" {
  pi_volume_size       = var.volume_tape_size
  pi_volume_name       = "${var.instance_name}_tape-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.powervs_workspace_guid
}
