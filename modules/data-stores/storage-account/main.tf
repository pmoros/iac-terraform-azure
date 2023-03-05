terraform {
  required_version = "=1.3.9"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "st${var.owner}${var.project}${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type

    network_rules {
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = [var.subnet_id]
  }

  tags = var.tags
}