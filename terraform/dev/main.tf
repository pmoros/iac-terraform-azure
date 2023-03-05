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

module "resource_group" {
  source      = "../../modules/resource-group"
  project     = var.project
  environment = var.environment
  location    = var.location
  tags        = var.tags
}

# Networks
module "vpc" {
  source              = "../../modules/networks/vpc"
  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

module "subnet" {
  source              = "../../modules/networks/subnet"
  resource_group_name = module.resource_group.resource_group_name
  vnet_name           = module.vpc.vnet_name
  subnets             = var.subnets
}

# App Service
module "app_service" {
  source              = "../../modules/services/app-service"
  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  sku_name            = var.sku_name
  site_config         = var.site_config
}

resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = module.app_service.web_app_id
  subnet_id      = module.subnet.subnet.webApp.id
}

# data "azurerm_subnet" "subnet" {
#   name                 = module.subnet.name
#   virtual_network_name = module.vpc.vnet_name
#   resource_group_name  = module.resource_group.resource_group_name
# }