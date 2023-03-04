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
  type        = map(any)
  default     = {}
  description = "Tags"
}

# services
variable "resource_group_name" {
  type        = string
  default     = "sample-rg"
  description = "Resource group name"
}

variable "sku_name" {
  type        = string
  default     = "Standard_B1ms"
  description = "SKU name"
}

variable "site_config" {
  type        = object({
    runtime_stack = string
    dotnet_version = string
  })
}
