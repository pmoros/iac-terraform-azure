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

# Service bus
module "service_bus" {
  source              = "../../modules/services/servicebus"
  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  servicebus_sku      = var.servicebus_sku
  tags                = var.tags
}

# Database
resource "random_password" "database_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "database" {
  source              = "../../modules/data-stores/database"
  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  administrator_login = var.administrator_login
  administrator_login_password = random_password.database_password.result
  tags                = var.tags
}



resource "azurerm_mssql_firewall_rule" "firewall_rule" {
  name                = "dbfr-${var.project}-${var.environment}-${var.location}"
  server_id        = module.database.database_server_id
  start_ip_address    = "172.16.1.1"
  end_ip_address      = "172.16.1.126"
}


# Storage account
module "storage_account" {
  source              = "../../modules/data-stores/storage-account"
  owner              = var.owner
  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  # Allow access from the subnet
  subnet_id           = module.subnet.subnet.webApp.id
  tags                = var.tags
}

# Key vault
module "key_vault" {
  source              = "../../modules/data-stores/key-vault"
  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  tags                = var.tags
}

