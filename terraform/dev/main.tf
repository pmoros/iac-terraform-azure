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

module "vpc" {
  source              = "../../modules/networks/vpc"
  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

# module "app_service" {
#   source     = "../../modules/services/app-service"

# }