terraform {
  required_version = "=1.3.9"
  backend "azurerm" {
    storage_account_name = "stpaulmorostfstate001"
    container_name       = "crtfstate001"
    key                  = "stage"
    access_key           = "0k2Dwr6pGvn81jehB77D5bQa47KjFBhqQsQqIVZeujXu6OLu40nsU6NgigDbcx+Cc10adTkHoHaD+ASteofe2Q=="
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source              = "../modules/resource-group"
  resource_group_name = "rg-activity-eastus"
  location            = "eastus"
}