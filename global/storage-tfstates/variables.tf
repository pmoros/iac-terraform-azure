# General
variable "location" {
  type        = string
  default     = "eastus"
  description = "The location/region where the resources in this example should be created."
}

variable "owner" {
  type        = string
  default     = "owner"
  description = "The name of the owner of this example."
}

variable "workload" {
  type        = string
  default     = "workload"
  description = "The name of the workload."
}

variable "instance_number" {
  type        = string
  default     = ""
  description = "The instance number."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "A mapping of tags to assign to the resources."
}

# Storage Account

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "The tier of the storage account."
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "The replication type of the storage account."
}

# Storage Container

variable "container_access_type" {
  type        = string
  default     = "private"
  description = "The access type of the storage container."
}


