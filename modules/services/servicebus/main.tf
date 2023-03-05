terraform {
  required_version = "=1.3.9"
}

resource "azurerm_servicebus_namespace" "namespace" {
  name                         = "sb-${var.project}-${var.environment}-${var.location}"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  local_auth_enabled    = false
  public_network_access_enabled = false

  sku = var.servicebus_sku
}

resource "azurerm_servicebus_queue" "queue" {
  name                = "sbq-${var.project}-${var.environment}-${var.location}"
  namespace_id        = azurerm_servicebus_namespace.namespace.id
  max_size_in_megabytes = 1024
  default_message_ttl = "PT5M"
}