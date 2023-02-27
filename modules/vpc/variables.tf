variable asg_name {
  type        = string
  default     = "asg_name"
  description = "Azure Security Group Name"
}

variable location {
    type        = string
    default     = "eastus"
    description = "Azure Location"
}

variable resource_group_name {
    type        = string
    default     = "resource_group_name"
    description = "Azure Resource Group Name"
}

variable vnet_name {
    type        = string
    default     = "vnet_name"
    description = "Azure Virtual Network Name"
}

variable address_space {
    type        = list(string)
    default     = ["10.0.0.0/16"]
    description = "Azure Virtual Network Address Space"
}