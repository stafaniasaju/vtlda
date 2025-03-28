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
  type        = number
  default     = 1
  description = "The StorSafe VTL licensed repository capacity in TB"
}

variable "memory" {
  type        = number
  default     = 18
  description = "The amount of memory to assign to the StorSafe VTL instance in GB according to the following formula: memory >= 16 + (2 * license_repository_capacity)"
}

variable "vcpus" {
  type        = number
  default     = 1
  description = "The number of vCPUs, AKA virtual processors, to assign to the StorSafe VTL instance; one vCPU is equal to one physical CPU core."
}

variable "instance_name" {
  type        = string
  default     = ""
  description = "The name to assign to the StorSafe VTL instance"
}

variable "processor_mode" {
  type        = string
  default     = "shared"
  description = "The type of processor mode in which the StorSafe VTL instance will run: 'shared', 'capped', or 'dedicated'"
}

variable "system_type" {
  type        = string
  default     = "s922"
  description = "The type of system on which to create the StorSafe VTL instance: 's922' or 'e980' for Power 9; 's1022' for Power 10 if present in the selected datacenter"
}

variable "storage_type" {
  type        = string
  default     = "tier1"
  description = "The type of storage tier for all volumes to attach to the StorSafe VTL instance: 'tier1' (high performance) or 'tier3'"
}

variable "management_net_ip" {
  type        = string
  default     = ""
  description = "The IP address from the management subnet to be assigned to the StorSafe VTL instance"
}

variable "backup_net_ip" {
  type        = string
  default     = ""
  description = "The IP address from the backup subnet to be assigned to the StorSafe VTL instance"
}

variable "network_3" {
  type        = string
  default     = ""
  description = "The network ID or name of a third subnet if already existing in the PowerVS workspace to assign to the StorSafe VTL instance"
}

variable "network_3_ip" {
  type        = string
  default     = ""
  description = "The IP address from the network_3 subnet to be assigned to the StorSafe VTL instance"
}

variable "placement_group" {
  type        = string
  default     = ""
  description = "The server placement group name where the StorSafe VTL instance will be placed, as defined for the selected Power Systems Virtual Server CRN"
}

variable "policy_affinity" {
  type        = string
  default     = "anti-affinity"
  description = "The storage anti-affinity policy to use for placement of the StorSafe VTL volume if PVM instance IDs are specified"
}

variable "pvm_instances" {
  type        = string
  default     = ""
  description = "The comma-separated list of PVM instance IDs for the storage anti-affinity policy used for placement of the StorSafe instance volume, as defined for the selected Power Systems Virtual Server CRN"
}

variable "volume_configuration_size" {
  type        = number
  default     = 20
  description = "The size of the block storage volume for the StorSafe VTL Configuration Repository in GB"
}

variable "volume_index_size" {
  type        = number
  default     = 1024
  description = "The size of the block storage volume for the index of StorSafe VTL Deduplication Repository in GB; the maximum size of a volume is 2 TB; attach extra volumes later, if necessary"
}

variable "volume_tape_size" {
  type        = number
  default     = 1024
  description = "The size of the block storage volume for the StorSafe VTL tape backup cache in GB; the maximum size of a volume is 2 TB; attach extra volumes later, if necessary"
}
