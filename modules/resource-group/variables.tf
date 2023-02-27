variable resource_group_name {
  type        = string
  default     = "rg"
  description = "The name of the resource group in which the resources will be created."
}

variable location {
  type        = string
  default     = "eastus"
  description = "The Azure location where all resources should be created."
}