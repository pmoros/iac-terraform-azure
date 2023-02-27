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
  resource_group_name = "rg-activity2-eastus"
  location            = "eastus"
}

module "vpc" {
  source              = "../modules/vpc"
  resource_group_name = module.resource_group.resource_group_name
  asg_name            = "asg-activity2-eastus"
  location            = "eastus"
  vnet_name           = "vnet-activity2-eastus"
  address_space       = ["172.16.1.0/24"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "web-app-activity2-eastus"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.vpc.vnet_name
  address_prefixes     = ["172.16.1.0/25"]
}

module "web_app" {
  source              = "../modules/services/app-service"
  resource_group_name = module.resource_group.resource_group_name
  location            = "eastus"
  appserviceplan_name = "asp-activity2-eastus"
  appservice_name     = "app-activity2-eastus"
  subnet_id           = azurerm_subnet.subnet.id
  sku_name            = "B1"
}

module "servicebus" {
  source              = "../modules/services/servicebus"
  resource_group_name = module.resource_group.resource_group_name
  location            = "eastus"
  servicebus_namespace_name      = "ns-activity2-eastus"
  servicebus_queue_name          = "queue-activity2-eastus"
  sku = "Standard"

}