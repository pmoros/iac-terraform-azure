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

variable asg_name {
  type        = string
  default     = "asg_name"
  description = "Azure Security Group Name"
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

variable tags {
    type        = map(any)
    default     = {
        "project"     = "sample"
        "environment" = "dev"
    }
    description = "Azure Resource Tags"
}