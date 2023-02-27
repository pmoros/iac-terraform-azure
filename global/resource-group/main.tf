terraform {
  required_version = "=1.3.9"
}

provider "azurerm" {    
    features {}
}

resource "azurerm_resource_group" "rg-activity2-eastus" {
  name     = "rg-activity2-${var.location}"
  location = var.location
}