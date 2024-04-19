########################################################################################################################
# Input Variables
########################################################################################################################

variable "crn" {
  type        = string
  default     = ""
  description = "Power Systems Virtual Server CRN"
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
variable "ssh_key_name" {
  type        = string
  default     = ""
  description = "The name of the public SSH RSA key to access the StorSafe VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_1" {
  type        = string
  default     = ""
  description = "The first network ID or name to assign to the StorSafe VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_1_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the first network rather than automatic assignment within the IP range"
}
variable "network_2" {
  type        = string
  default     = ""
  description = "The second network ID or name to assign to the StorSafe VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_2_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the second network rather than automatic assignment within the IP range"
}
variable "network_3" {
  type        = string
  default     = ""
  description = "The third network ID or name to assign to the StorSafe VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_3_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the third network rather than automatic assignment within the IP range"
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
