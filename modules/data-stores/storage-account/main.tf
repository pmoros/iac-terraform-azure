terraform {
  required_version = ">=1.3.9"
}

resource "azurerm_storage_account" "stpaulmorosact002" {
  name                     = "stpaulmorosact002"
  resource_group_name      = "rg-activity2-${var.location}"
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    lob = "learning"
    workload = "activity2"
  }

  network_rules {
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = [var.subnet_id]
  }  
  
}