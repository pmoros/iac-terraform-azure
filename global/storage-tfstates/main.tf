terraform {
  required_version = "=1.3.9"
  backend "azurerm" {
    # uses -backend-config to pass in the following variables
    # - resource_group_name
    # - storage_account_name
    # - container_name
    # - key    
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfstates" {
  name     = "rg-tfstates-${var.workload}-${var.location}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "tfstates" {
  name                     = "st${var.owner}tfstates${var.instance_number}"
  resource_group_name      = azurerm_resource_group.tfstates.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = var.tags
}

resource "azurerm_storage_container" "tfstates" {
  name                  = "crtfstates${var.workload}"
  storage_account_name  = azurerm_storage_account.tfstates.name
  container_access_type = var.container_access_type
}