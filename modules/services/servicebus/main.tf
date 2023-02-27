resource "azurerm_servicebus_namespace" "namespace" {
  name                         = var.servicebus_namespace_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  local_auth_enabled    = false
  public_network_access_enabled = false

  sku = var.sku
}

resource "azurerm_servicebus_queue" "queue" {
  name                = var.servicebus_queue_name
  namespace_id        = azurerm_servicebus_namespace.namespace.id
  max_size_in_megabytes = 1024
  default_message_ttl = "PT5M"
}