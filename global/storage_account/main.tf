terraform {
  required_version = "=1.3.9"
  backend "azurerm" {
    storage_account_name = "stpaulmorostfstate001"
    container_name       = "crtfstate001"
    key                  = "global/storage-account"
    access_key           = "0k2Dwr6pGvn81jehB77D5bQa47KjFBhqQsQqIVZeujXu6OLu40nsU6NgigDbcx+Cc10adTkHoHaD+ASteofe2Q=="
  }
}

provider "azurerm" {
    features {}
}

resource "azurerm_storage_account" "stpaulmorostfstate001" {
  name                     = "stpaulmorostfstate001"
  resource_group_name      = "rg-terraform-${var.location}"
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    lob = "learning"
    workload = "terraform"
  }  
}

resource "azurerm_storage_container" "crtfstate001" {
  name                  = "crtfstate001"
  storage_account_name  = azurerm_storage_account.stpaulmorostfstate001.name
  container_access_type = "private"
}