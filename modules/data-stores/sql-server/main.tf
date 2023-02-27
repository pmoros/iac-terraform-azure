data "azurerm_client_config" "current" {}


resource "azurerm_sql_server" "sqlserver" {
  name                         = "sql-server-activity2-eastus"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
    identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_sql_database" "database" {
  name                = "AdventureWorksLT"
  resource_group_name = var.resource_group_name
    location            = var.location
  server_name         = azurerm_sql_server.sqlserver.name
  edition             = "Standard"
  requested_service_objective_name = "S1"

}

resource "azurerm_sql_active_directory_administrator" "active_directory_administrator" {
  server_name          = azurerm_sql_server.sqlserver.name
  resource_group_name = var.resource_group_name  
  login              = var.login  
    tenant_id          = data.azurerm_client_config.current.tenant_id
    object_id          = var.object_id
}


resource "azurerm_sql_firewall_rule" "firewall_rule" {
  name                = "db_firewall_rule"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  start_ip_address    = "172.16.1.1"
  end_ip_address      = "172.16.1.126"
}