###############################################################
# Deploy StorSight instance in Edge VPC
###############################################################

module "create_storsight_instance" {
  count   = var.create_storsight_instance ? 1 : 0
  source  = "terraform-ibm-modules/landing-zone-vsi/ibm"
  version = "4.7.1"

  create_security_group = false
  image_id              = data.ibm_is_image.is_instance_boot_image_data[0].id
  machine_type          = var.is_instance_profile
  prefix                = local.prefix
  resource_group_id     = local.resource_group_id
  security_group_ids    = local.security_group_ids
  ssh_key_ids           = local.ssh_key_ids
  subnets               = local.subnets
  user_data             = ""
  vpc_id                = local.vpc_id
  vsi_per_subnet        = 1
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
  pi_affinity_policy             = length(var.pvm_instances) > 0 ? var.affinity_policy : null
  pi_anti_affinity_instances     = length(var.pvm_instances) > 0 ? split(",", var.pvm_instances) : null
  pi_placement_group_id          = local.placement_group_id
  pi_license_repository_capacity = var.repository_capacity == 0 ? 1 : var.repository_capacity # deprecated
  pi_network {
    network_id = data.ibm_pi_network.powervs_management_subnet.id
    ip_address = length(var.management_net_ip) > 0 ? var.management_net_ip : ""
  }
  dynamic "pi_network" {
    for_each = local.pi_subnet_list
    content {
      network_id = pi_network.value.id
      ip_address = pi_network.value.ip != null && pi_network.value.ip != "" ? pi_network.value.ip : null
    }
  }
  lifecycle {
    precondition {
      condition     = local.pi_image_id != null
      error_message = "The provided PowerVS boot image name ${var.pi_instance_boot_image} is not found in ibm_pi_catalog_images."
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
