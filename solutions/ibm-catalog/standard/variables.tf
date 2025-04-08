###############################################################
# Inputs
###############################################################
variable "ibmcloud_api_key" {
  description = "IBM Cloud platform API key needed to deploy IAM enabled resources."
  type        = string
  sensitive   = true
}

variable "prerequisite_workspace_id" {
  description = "IBM Cloud Schematics workspace ID of an existing 'Power Virtual Server with VPC landing zone' catalog solution. If you do not yet have an existing deployment, click [here](https://cloud.ibm.com/catalog/architecture/deploy-arch-ibm-pvs-inf-2dd486c7-b317-4aaa-907b-42671485ad96-global?) to create one."
  type        = string
}

variable "repository_capacity" {
  description = "The StorSafe VTL licensed repository capacity in TB."
  type        = number
  default     = 1
}

variable "memory" {
  description = "The amount of memory to assign to the StorSafe VTL instance in GB according to the following formula: memory >= 16 + (2 * license_repository_capacity)."
  type        = number
  default     = 18

}

variable "vcpus" {
  description = "The number of vCPUs, AKA virtual processors, to assign to the StorSafe VTL instance; one vCPU is equal to one physical CPU core."
  type        = number
  default     = 1
}

variable "instance_name" {
  description = "The name to assign to the StorSafe VTL instance."
  type        = string
}

variable "processor_mode" {
  description = "The type of processor mode in which the StorSafe VTL instance will run: 'shared', 'capped', or 'dedicated'."
  type        = string
  default     = "shared"
}

variable "system_type" {
  description = "The type of system on which to create the StorSafe VTL instance: 's922' or 'e980' for Power 9; 's1022' for Power 10 if present in the selected datacenter."
  type        = string
  default     = "s922"
}

variable "storage_type" {
  description = "The type of storage tier for all volumes to attach to the StorSafe VTL instance: 'tier1' (high performance) or 'tier3'."
  type        = string
  default     = "tier1"
}

variable "management_net_ip" {
  description = "The IP address from the management subnet to be assigned to the StorSafe VTL instance."
  type        = string
  default     = ""
}

variable "backup_net_ip" {
  description = "The IP address from the backup subnet to be assigned to the StorSafe VTL instance."
  type        = string
  default     = ""
}

variable "network_3" {
  description = "The network ID or name of a third subnet if already existing in the PowerVS workspace to assign to the StorSafe VTL instance."
  type        = string
  default     = ""
}

variable "network_3_ip" {
  description = "The IP address from the network_3 subnet to be assigned to the StorSafe VTL instance."
  type        = string
  default     = ""
}

variable "network_4" {
  description = "The network ID or name of a third subnet if already existing in the PowerVS workspace to assign to the StorSafe VTL instance."
  type        = string
  default     = ""
}

variable "network_4_ip" {
  description = "The IP address from the network_3 subnet to be assigned to the StorSafe VTL instance."
  type        = string
  default     = ""
}

variable "placement_group" {
  description = "The server placement group name where the StorSafe VTL instance will be placed, as defined for the selected Power Systems Virtual Server CRN."
  type        = string
  default     = ""
}

variable "affinity_policy" {
  description = "The storage anti-affinity policy to use for placement of the StorSafe VTL volume if PVM instance IDs are specified."
  type        = string
  default     = "anti-affinity"
}

variable "pvm_instances" {
  description = "The comma-separated list of PVM instance IDs for the storage anti-affinity policy used for placement of the StorSafe instance volume, as defined for the selected Power Systems Virtual Server CRN."
  type        = string
  default     = ""
}

variable "volume_configuration_size" {
  description = "The size of the block storage volume for the StorSafe VTL Configuration Repository in GB."
  type        = number
  default     = 20
}

variable "volume_index_size" {
  description = "The size of the block storage volume for the index of StorSafe VTL Deduplication Repository in GB; the maximum size of a volume is 2 TB; attach extra volumes later, if necessary."
  type        = number
  default     = 1024
}

variable "volume_tape_size" {
  description = "The size of the block storage volume for the StorSafe VTL tape backup cache in GB; the maximum size of a volume is 2 TB; attach extra volumes later, if necessary."
  type        = number
  default     = 1024
}

variable "create_storsight_instance" {
  description = "The boolean option to create a windows StorSight instance in the Edge VPC of the pre-requisite Landing zone infrastructure."
  type        = bool
  default     = false
}

# hidden variables
variable "pi_instance_boot_image" {
  description = "The boot image to be used while creating the StorSafe VTL PowerVS instance."
  type        = string
  default     = "VTL-FalconStor-11_13_001"
}

variable "is_instance_boot_image" {
  description = "The boot image to be used while creating the StorSight VPC instance."
  type        = string
  default     = "ibm-windows-server-2022-full-standard-amd64-23"
  #default = "faulty"
}

variable "is_instance_profile" {
  description = "The boot image to be used while creating the StorSight VPC instance."
  type        = string
  default     = "bx2-2x8"
}
