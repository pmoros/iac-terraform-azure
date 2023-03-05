data "azurerm_client_config" "current" {}


resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sqldb-${var.project}-${var.environment}-${var.location}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
    identity {
    type = "SystemAssigned"
  }

  azuread_administrator {
    login_username = "AzureAD ${var.administrator_login}"
    object_id      = data.azurerm_client_config.current.object_id
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "database" {
  name                = "AdventureWorksLT"
  server_id       = azurerm_mssql_server.sqlserver.id
}
