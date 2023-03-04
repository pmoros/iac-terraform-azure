# General
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}


# Network
variable "address_space" {
  type        = list(string)
  default     = ["172.16.1.0/24"]
  description = "Address space"
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


# Services
variable "sku_name" {
  type        = string
  default     = "Standard_B1ms"
  description = "SKU name"
}

variable "site_config" {
  type = object({
    runtime_stack  = string
    dotnet_version = string
  })
}


