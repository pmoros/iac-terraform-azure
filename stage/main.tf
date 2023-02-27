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
  service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.ServiceBus"]
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


resource "azurerm_key_vault_access_policy" "kvap_org" {
  key_vault_id = module.key_vault.key_vault_id
  tenant_id    = module.key_vault.tenant_id
  object_id    = module.key_vault.object_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]

storage_permissions = [
    "Get",
]  
}

resource "azurerm_key_vault_access_policy" "kvap_alejandro" {
  key_vault_id = module.key_vault.key_vault_id
  tenant_id    = module.key_vault.tenant_id
  object_id    = "34dec84a-67fb-42b8-b7cf-64998f2ed072"

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]

storage_permissions = [
    "Get",
]  
}

resource "azurerm_key_vault_access_policy" "kvap_walter" {
  key_vault_id = module.key_vault.key_vault_id
  tenant_id    = module.key_vault.tenant_id
  object_id    = "95c7d29c-45e7-4171-8356-525ac9c3e85a"

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]

storage_permissions = [
    "Get",
]  
}

module "storage_account" {
  source             = "../modules/data-stores/storage-account"  
  location          = "eastus"
  subnet_id          = azurerm_subnet.subnet.id
}