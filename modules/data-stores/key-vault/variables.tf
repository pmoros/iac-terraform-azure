variable key_vault_name {
  type        = string
    default     = "key-vault"
    description = "The name of the Key Vault."
}

variable location {
  type        = string
  default     = "eastus"
  description = "The Azure location where all resources should be created."
}

variable resource_group_name {
    type        = string
    default     = "key-vault-rg"
    description = "The name of the resource group in which to create all resources."
}

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