terraform {
  required_version = ">=1.3.9"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project}-${var.environment}-${var.location}"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

