variable "appserviceplan_name" {
  type    = string
  default = "appserviceplan"
}

variable "appservice_name" {
  type    = string
  default = "appservice"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = "rg"
}

variable "subnet_id" {
  type    = string
  default = "subnet_id"
}

variable "sku_name" {
  type    = string
  default = "S1"
}