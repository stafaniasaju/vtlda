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
# Data of boot image for windows instance in VPC
###############################################################

data "ibm_is_image" "storsight_boot_image_data" {
  count = var.create_storsight_instance ? 1 : 0
  name  = var.custom_storsight_image.name
  depends_on = [
    ibm_is_image.import_custom_storsight_image
  ]
}

data "ibm_is_image" "is_instance_boot_image_data" {
  count = var.create_windows_instance ? 1 : 0
  name  = var.windows_instance_configuration.boot_image
}

data "ibm_is_instance" "network_services_instance" {
  count = local.get_vpc_data ? 1 : 0
  name  = local.network_services_instance.name
}

data "ibm_is_volume" "network_services_instance_boot_volume" {
  identifier = data.ibm_is_instance.network_services_instance[0].boot_volume[0].volume_id
}

###############################################################
# Data for Catalog Stock Images
###############################################################
data "ibm_pi_catalog_images" "catalog_images_ds" {
  pi_cloud_instance_id = local.powervs_workspace_guid
  vtl                  = true
}

###############################################################
# Data for Virtual Appliance Instance and Volumes creation
###############################################################
data "ibm_pi_placement_groups" "cloud_instance_groups" {
  pi_cloud_instance_id = local.powervs_workspace_guid
}

data "ibm_pi_network" "existing_subnets" {
  for_each = local.enable_existing_subnets_attach ? { for subnet in var.existing_subnets : subnet.name => subnet } : {}

  pi_cloud_instance_id = local.powervs_workspace_guid
  pi_network_name      = each.value.name
}
