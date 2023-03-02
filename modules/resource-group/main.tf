terraform {
  required_version = ">=1.3.9"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}