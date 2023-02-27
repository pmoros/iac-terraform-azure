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

data "azurerm_client_config" "current" {}

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
  service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.ServiceBus", "Microsoft.Sql"]
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


module "key_vault" {
  source              = "../modules/data-stores/key-vault"
  resource_group_name = module.resource_group.resource_group_name
  location            = "eastus"
  key_vault_sku            = "standard"
  key_vault_name      = "pmoros-kv-act2-eastus"
  subnet_id           = azurerm_subnet.subnet.id
}

resource "azurerm_key_vault_access_policy" "user-policy-001" {
  key_vault_id = module.key_vault.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Backup",
    "Restore"
  ]
}

resource "azurerm_key_vault_access_policy" "user-policy-002" {
  key_vault_id = module.key_vault.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = "95c7d29c-45e7-4171-8356-525ac9c3e85a"

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Backup",
    "Restore"
  ]
}

resource "azurerm_key_vault_access_policy" "user-policy-003" {
  key_vault_id = module.key_vault.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = "34dec84a-67fb-42b8-b7cf-64998f2ed072"

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Backup",
    "Restore"
  ]
}

resource "azurerm_key_vault_access_policy" "user-policy-004" {
  key_vault_id = module.key_vault.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = "c160a942-c869-429f-8a96-f8c8296d57db"


  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Backup",
    "Restore"
  ]
}

module "storage_account" {
  source             = "../modules/data-stores/storage-account"  
  location          = "eastus"
  subnet_id          = azurerm_subnet.subnet.id
}

# !: Secrets issue with user c160a942-c869-429f-8a96-f8c8296d57db
# resource "azurerm_key_vault_secret" "username" {
#   name         = "db-username"
#   value        = "yourusername"
#   key_vault_id = module.key_vault.key_vault_id
# }


# resource "azurerm_key_vault_secret" "password" {
#   name         = "db-password"
#   value        = "4-V3ry-53cr37-P455w0rd?"
#   key_vault_id = module.key_vault.key_vault_id
# }

module "sql_server" {
  source              = "../modules/data-stores/sql-server"
  resource_group_name = module.resource_group.resource_group_name
  location            = "eastus"  
  administrator_login = "yourusername"
  administrator_login_password = "4-V3ry-53cr37-P455w0rd?"
  login = "paul.moros@globant.com"  
  object_id = "c160a942-c869-429f-8a96-f8c8296d57db"  
}
