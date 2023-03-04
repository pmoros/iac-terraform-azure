variable "resource_group_name" {
  type        = string
  default     = "myResourceGroup"
  description = "The name of the resource group in which the resources will be created."
}

variable "vnet_name" {
  type        = string
  default     = "myVnet"
  description = "The name of the virtual network."
}

variable "subnets" {
  type = map(object({
    prefixes = list(string)
  }))
  default = {
    "subnet1" = {
      prefixes = [""]
    }
  }    
  description = "The list of subnets to create in the virtual network."
}
