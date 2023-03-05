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

# Key vault
variable key_vault_sku {
    type        = string
    default     = "standard"
    description = "The SKU of the Key Vault."
}

variable subnet_id {
    type        = string
    default     = ""
    description = "The ID of the subnet in which to create the Key Vault."
}

# Tags
variable tags {
    type        = map(any)
    default     = {}
    description = "A mapping of tags to assign to the resource."
}