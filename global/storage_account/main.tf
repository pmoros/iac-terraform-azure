terraform {
  required_version = "=1.3.9"
}

provider "azurerm" {
    features {}
}

resource "azurerm_storage_account" "stpaulmorosdefault001" {
  name                     = "stpaulmorosdefault001"
  resource_group_name      = "rg-activity2-${var.location}"
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    lob = "learning"
    workload = "activity2"
  }  
}

resource "azurerm_storage_container" "crterraformstate001" {
  name                  = "crterraformstate001"
  storage_account_name  = azurerm_storage_account.stpaulmorosdefault001.name
  container_access_type = "private"
}