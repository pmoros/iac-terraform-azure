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
# Service bus
variable "resource_group_name" {
  type        = string
  default     = "resource_group_name"
  description = "Azure Resource Group Name"
}

variable servicebus_sku {
  type        = string
  default     = "Standard"
  description = "Service bus SKU"
}


variable "tags" {
  type = map(any)
  default = {
    "project"     = "sample"
    "environment" = "dev"
  }
  description = "Azure Resource Tags"
}