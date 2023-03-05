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


data "azurerm_client_config" "current" {}

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
resource "azurerm_key_vault" "kv" {
  name                        = "kv${var.owner}${var.project}${var.environment}"
  location                    = var.location
  resource_group_name         = module.resource_group.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  sku_name = var.keyvault_sku

  network_acls {
    default_action             = "Allow"
    bypass                     = "AzureServices"
    ip_rules                   = []    
    virtual_network_subnet_ids = [module.subnet.subnet.webApp.id]
  }

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "defined_access_policy" {
  for_each = toset(concat(var.object_ids, [data.azurerm_client_config.current.object_id]))
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value

  key_permissions = [
    "Get", "Update", "Delete", "List", "Encrypt", "Decrypt", 
  ]

  secret_permissions = [
    "Get", "Delete", "List", "Set", "Recover",  "Backup", "Restore", "Purge"
  ]  

  depends_on = [azurerm_key_vault.kv]
}

resource "azurerm_key_vault_secret" "db_username" {
  name         = "dbusername"
  value        = var.administrator_login
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.defined_access_policy]
}


resource "azurerm_key_vault_secret" "db_password" {
  name         = "dbpassword"
  value        = random_password.database_password.result
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.defined_access_policy]
}
