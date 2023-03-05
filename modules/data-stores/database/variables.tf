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

# Database
variable administrator_login {
    type        = string
    description = "The administrator username of the SQL Server."
}

variable administrator_login_password {
    type        = string
    description = "The administrator password of the SQL Server."
    sensitive   = true
}

variable "tags" {
  type = map(any)
  default = {
    "project"     = "sample"
    "environment" = "dev"
  }
  description = "Azure Resource Tags"
}