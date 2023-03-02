terraform {
  required_version = ">=1.3.9"
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

resource "azurerm_resource_group" "rg-terraform-eastus" {
  name     = "rg-terraform-${var.location}"
  location = var.location
}