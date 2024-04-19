########################################################################################################################
# Input Variables
########################################################################################################################

variable "region" {
  type        = string
  default     = "us-south"
  description = "The region where to deploy the resources"
}

variable "tags" {
  type    = list(string)
  default = ["terraform", "simple-da"]
}

variable "prefix" {
  type        = string
  default     = ""
  description = "A prefix for all resources to be created. If none provided a random prefix will be created"
}

