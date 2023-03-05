terraform {
  required_version = "=1.3.9"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.project}-${var.environment}-${var.location}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  sku_name = var.key_vault_sku

  network_acls {
    default_action             = "Allow"
    bypass                     = "AzureServices"
    ip_rules                   = []    
    virtual_network_subnet_ids = [var.subnet_id]
  }

  tags = var.tags
}

