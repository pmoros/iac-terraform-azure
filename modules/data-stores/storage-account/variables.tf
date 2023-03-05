variable "owner" {
  type        = string
  default     = "sample"
  description = "Owner name"
  sensitive  = true
}

variable "project" {
  type        = string
  default     = "sample"
  description = "Project name"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Region"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable resource_group_name {
    type        = string
    description = "The name of the resource group in which to create the resources."
}

# Storage Account

variable account_tier {
    type        = string
    description = "The tier of the storage account."
    default     = "Standard"
}

variable replication_type {
    type        = string
    description = "The replication type of the storage account."
    default     = "LRS"
}

variable subnet_id {
    type        = string
    description = "The ID of the subnet in which to create the storage account."
}

# Tags
variable "tags" {
  type        = map(any)
  default     = {}
  description = "Tags to apply to all resources"
}