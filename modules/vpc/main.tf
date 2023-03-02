terraform {
  required_version = ">=1.3.9"
}

resource "azurerm_network_security_group" "asg" {
  name                = var.asg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}