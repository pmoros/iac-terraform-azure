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

variable address_space {
  type        = list(string)
  default     = ["172.16.1.0/24"]
  description = "Address space"
}