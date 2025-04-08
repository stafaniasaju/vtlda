<!-- Update the title -->
# Deployable Module Template

<!-- Update the below text with the name of the module  -->

A thin wrapper around the [terraform-ibm-module-template](../../) module which includes a provider configuration meaning it can be deployed as is.
This is not intended to be called by one or more other modules since it contains a provider configuration, meaning it is not compatible with the `for_each`, `count`, and `depends_on` arguments. For more information see [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers).

<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.75.2 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_storsight_instance"></a> [create\_storsight\_instance](#module\_create\_storsight\_instance) | terraform-ibm-modules/landing-zone-vsi/ibm | 4.7.1 |

### Resources

| Name | Type |
|------|------|
| [ibm_pi_instance.instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/resources/pi_instance) | resource |
| [ibm_pi_volume.configuration_volume](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/resources/pi_volume) | resource |
| [ibm_pi_volume.index_volume](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/resources/pi_volume) | resource |
| [ibm_pi_volume.tape_volume](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/resources/pi_volume) | resource |
| [ibm_is_image.is_instance_boot_image_data](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/is_image) | data source |
| [ibm_is_instance.network_services_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/is_instance) | data source |
| [ibm_is_subnet.network_services_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/is_subnet) | data source |
| [ibm_is_vpc.edge_vpc_data](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/is_vpc) | data source |
| [ibm_pi_catalog_images.catalog_images_ds](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/pi_catalog_images) | data source |
| [ibm_pi_key.key](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/pi_key) | data source |
| [ibm_pi_network.network_3](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/pi_network) | data source |
| [ibm_pi_network.network_4](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/pi_network) | data source |
| [ibm_pi_network.powervs_backup_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/pi_network) | data source |
| [ibm_pi_network.powervs_management_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/pi_network) | data source |
| [ibm_pi_placement_groups.cloud_instance_groups](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/pi_placement_groups) | data source |
| [ibm_schematics_output.schematics_output](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/schematics_output) | data source |
| [ibm_schematics_workspace.schematics_workspace](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.75.2/docs/data-sources/schematics_workspace) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_affinity_policy"></a> [affinity\_policy](#input\_affinity\_policy) | The storage anti-affinity policy to use for placement of the StorSafe VTL volume if PVM instance IDs are specified. | `string` | `"anti-affinity"` | no |
| <a name="input_backup_net_ip"></a> [backup\_net\_ip](#input\_backup\_net\_ip) | The IP address from the backup subnet to be assigned to the StorSafe VTL instance. | `string` | `""` | no |
| <a name="input_create_storsight_instance"></a> [create\_storsight\_instance](#input\_create\_storsight\_instance) | The boolean option to create a windows StorSight instance in the Edge VPC of the pre-requisite Landing zone infrastructure. | `bool` | `false` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | IBM Cloud platform API key needed to deploy IAM enabled resources. | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name to assign to the StorSafe VTL instance. | `string` | n/a | yes |
| <a name="input_is_instance_boot_image"></a> [is\_instance\_boot\_image](#input\_is\_instance\_boot\_image) | The boot image to be used while creating the StorSight VPC instance. | `string` | `"ibm-windows-server-2022-full-standard-amd64-23"` | no |
| <a name="input_is_instance_profile"></a> [is\_instance\_profile](#input\_is\_instance\_profile) | The boot image to be used while creating the StorSight VPC instance. | `string` | `"bx2-2x8"` | no |
| <a name="input_management_net_ip"></a> [management\_net\_ip](#input\_management\_net\_ip) | The IP address from the management subnet to be assigned to the StorSafe VTL instance. | `string` | `""` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory to assign to the StorSafe VTL instance in GB according to the following formula: memory >= 16 + (2 * license\_repository\_capacity). | `number` | `18` | no |
| <a name="input_network_3"></a> [network\_3](#input\_network\_3) | The network ID or name of a third subnet if already existing in the PowerVS workspace to assign to the StorSafe VTL instance. | `string` | `""` | no |
| <a name="input_network_3_ip"></a> [network\_3\_ip](#input\_network\_3\_ip) | The IP address from the network\_3 subnet to be assigned to the StorSafe VTL instance. | `string` | `""` | no |
| <a name="input_network_4"></a> [network\_4](#input\_network\_4) | The network ID or name of a third subnet if already existing in the PowerVS workspace to assign to the StorSafe VTL instance. | `string` | `""` | no |
| <a name="input_network_4_ip"></a> [network\_4\_ip](#input\_network\_4\_ip) | The IP address from the network\_3 subnet to be assigned to the StorSafe VTL instance. | `string` | `""` | no |
| <a name="input_pi_instance_boot_image"></a> [pi\_instance\_boot\_image](#input\_pi\_instance\_boot\_image) | The boot image to be used while creating the StorSafe VTL PowerVS instance. | `string` | `"VTL-FalconStor-11_13_001"` | no |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | The server placement group name where the StorSafe VTL instance will be placed, as defined for the selected Power Systems Virtual Server CRN. | `string` | `""` | no |
| <a name="input_prerequisite_workspace_id"></a> [prerequisite\_workspace\_id](#input\_prerequisite\_workspace\_id) | IBM Cloud Schematics workspace ID of an existing 'Power Virtual Server with VPC landing zone' catalog solution. If you do not yet have an existing deployment, click [here](https://cloud.ibm.com/catalog/architecture/deploy-arch-ibm-pvs-inf-2dd486c7-b317-4aaa-907b-42671485ad96-global?) to create one. | `string` | n/a | yes |
| <a name="input_processor_mode"></a> [processor\_mode](#input\_processor\_mode) | The type of processor mode in which the StorSafe VTL instance will run: 'shared', 'capped', or 'dedicated'. | `string` | `"shared"` | no |
| <a name="input_pvm_instances"></a> [pvm\_instances](#input\_pvm\_instances) | The comma-separated list of PVM instance IDs for the storage anti-affinity policy used for placement of the StorSafe instance volume, as defined for the selected Power Systems Virtual Server CRN. | `string` | `""` | no |
| <a name="input_repository_capacity"></a> [repository\_capacity](#input\_repository\_capacity) | The StorSafe VTL licensed repository capacity in TB. | `number` | `1` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The type of storage tier for all volumes to attach to the StorSafe VTL instance: 'tier1' (high performance) or 'tier3'. | `string` | `"tier1"` | no |
| <a name="input_system_type"></a> [system\_type](#input\_system\_type) | The type of system on which to create the StorSafe VTL instance: 's922' or 'e980' for Power 9; 's1022' for Power 10 if present in the selected datacenter. | `string` | `"s922"` | no |
| <a name="input_vcpus"></a> [vcpus](#input\_vcpus) | The number of vCPUs, AKA virtual processors, to assign to the StorSafe VTL instance; one vCPU is equal to one physical CPU core. | `number` | `1` | no |
| <a name="input_volume_configuration_size"></a> [volume\_configuration\_size](#input\_volume\_configuration\_size) | The size of the block storage volume for the StorSafe VTL Configuration Repository in GB. | `number` | `20` | no |
| <a name="input_volume_index_size"></a> [volume\_index\_size](#input\_volume\_index\_size) | The size of the block storage volume for the index of StorSafe VTL Deduplication Repository in GB; the maximum size of a volume is 2 TB; attach extra volumes later, if necessary. | `number` | `1024` | no |
| <a name="input_volume_tape_size"></a> [volume\_tape\_size](#input\_volume\_tape\_size) | The size of the block storage volume for the StorSafe VTL tape backup cache in GB; the maximum size of a volume is 2 TB; attach extra volumes later, if necessary. | `number` | `1024` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_powervs_backup_subnet"></a> [powervs\_backup\_subnet](#output\_powervs\_backup\_subnet) | Name, ID and CIDR of backup private network in created PowerVS infrastructure. |
| <a name="output_powervs_management_subnet"></a> [powervs\_management\_subnet](#output\_powervs\_management\_subnet) | Name, ID and CIDR of management private network in created PowerVS infrastructure. |
| <a name="output_powervs_stor_safe_vtl_instance"></a> [powervs\_stor\_safe\_vtl\_instance](#output\_powervs\_stor\_safe\_vtl\_instance) | All private IPS of FalconStor instance. |
| <a name="output_powervs_stor_safe_vtl_volume_list"></a> [powervs\_stor\_safe\_vtl\_volume\_list](#output\_powervs\_stor\_safe\_vtl\_volume\_list) | All private IPS of FalconStor instance. |
| <a name="output_powervs_workspace_guid"></a> [powervs\_workspace\_guid](#output\_powervs\_workspace\_guid) | PowerVS infrastructure workspace guid. The GUID of the resource instance. |
| <a name="output_powervs_workspace_name"></a> [powervs\_workspace\_name](#output\_powervs\_workspace\_name) | PowerVS infrastructure workspace name. |
| <a name="output_powervs_zone"></a> [powervs\_zone](#output\_powervs\_zone) | Zone where PowerVS infrastructure is created. |
| <a name="output_storsight_vsi"></a> [storsight\_vsi](#output\_storsight\_vsi) | A list of VSI with name, id, zone, and primary ipv4 address |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
