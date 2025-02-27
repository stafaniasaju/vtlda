locals {
  location = regex("^[a-z/-]+", var.prerequisite_workspace_id)
}

data "ibm_schematics_workspace" "schematics_workspace" {
  provider     = ibm.ibm_sch
  workspace_id = var.prerequisite_workspace_id
  location     = local.location
}

data "ibm_schematics_output" "schematics_output" {
  provider     = ibm.ibm_sch
  workspace_id = var.prerequisite_workspace_id
  location     = local.location
  template_id  = data.ibm_schematics_workspace.schematics_workspace.runtime_data[0].id
}

locals {
  powervs_infrastructure  = jsondecode(data.ibm_schematics_output.schematics_output.output_json)
  powervs_workspace_guid  = local.powervs_infrastructure[0].powervs_workspace_guid.value
  powervs_workspace_crn   = local.powervs_infrastructure[0].powervs_workspace_id.value
  powervs_sshkey_name     = local.powervs_infrastructure[0].powervs_ssh_public_key.value.name
  powervs_images          = local.powervs_infrastructure[0].powervs_images.value
  powervs_mgmt_net        = local.powervs_infrastructure[0].powervs_management_subnet.value.name
  powervs_bkp_net         = local.powervs_infrastructure[0].powervs_backup_subnet.value.name
}

data "ibm_pi_catalog_images" "catalog_images" {
  sap                  = true
  vtl                  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_images" "cloud_instance_images" {
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_placement_groups" "cloud_instance_groups" {
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_key" "key" {
  pi_cloud_instance_id = local.pid
  pi_key_name          = local.powervs_sshkey_name
}
data "ibm_pi_network" "network_1" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = local.powervs_mgmt_net
}
data "ibm_pi_network" "network_2" {
  count = length(local.powervs_bkp_net) > 0 ? 1 : 0
  pi_cloud_instance_id = local.pid
  pi_network_name      = local.powervs_bkp_net
}
data "ibm_pi_network" "network_3" {
  count = length(var.network_3) > 0 ? 1 : 0
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.network_3
}
locals {
  stock_image_name = "VTL-FalconStor-11_13_001"
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.stock_image_name]
  private_image = [for x in data.ibm_pi_images.cloud_instance_images.image_info : x if x.name == local.stock_image_name]
  private_image_id = length(local.private_image) > 0 ? local.private_image[0].id  : ""
  placement_group = [for x in data.ibm_pi_placement_groups.cloud_instance_groups.placement_groups : x if x.name == var.placement_group]
  placement_group_id = length(local.placement_group) > 0 ? local.placement_group[0].id : ""
}

resource "ibm_pi_image" "stock_image_copy" {
  count = length(local.private_image_id) == 0 ? 1 : 0
  pi_image_name       = local.stock_image_name
  pi_image_id         = local.catalog_image[0].image_id
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.pid
  pi_memory            = var.memory
  pi_processors        = var.vcpus
  pi_instance_name     = var.instance_name
  pi_proc_type         = var.processor_mode
  pi_image_id          = length(local.private_image_id) == 0 ? ibm_pi_image.stock_image_copy[0].image_id : local.private_image_id
  pi_sys_type          = var.system_type
  pi_storage_type      = var.storage_type
  pi_key_pair_name     = length(local.powervs_sshkey_name) > 0 ? data.ibm_pi_key.key.id : null
  pi_affinity_policy   = length(var.pvm_instances) > 0 ? var.policy_affinity : null
  pi_anti_affinity_instances = length(var.pvm_instances) > 0 ? split(",", var.pvm_instances) : null
  pi_placement_group_id = local.placement_group_id
  pi_license_repository_capacity = var.repository_capacity
  pi_network {
    network_id = data.ibm_pi_network.network_1.id
    ip_address = length(var.network_1_ip) > 0 ? var.network_1_ip : ""
  }
  dynamic "pi_network" {
    for_each = local.powervs_bkp_net == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_2[0].id
      ip_address = length(var.network_2_ip) > 0 ? var.network_2_ip : ""
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

resource "ibm_pi_volume" "configuration_volume"{
  pi_volume_size       = var.volume_configuration_size
  pi_volume_name       = "${var.instance_name}_configuration-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_volume" "configuration_volume" {
  pi_volume_name       = ibm_pi_volume.configuration_volume.pi_volume_name
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_volume" "index_volume"{
  pi_volume_size       = var.volume_index_size
  pi_volume_name       = "${var.instance_name}_index-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_volume" "index_volume" {
  pi_volume_name       = ibm_pi_volume.index_volume.pi_volume_name
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_volume" "tape_volume"{
  pi_volume_size       = var.volume_tape_size
  pi_volume_name       = "${var.instance_name}_tape-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_volume" "tape_volume" {
  pi_volume_name       = ibm_pi_volume.tape_volume.pi_volume_name
  pi_cloud_instance_id = local.pid
}
