terraform {
  required_version = "=1.3.9"
}

resource "azurerm_service_plan" "service_plan" {
  name                = "sp-${var.project}-${var.environment}-${var.location}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name
  os_type             = "Windows"
  tags               = var.tags
}

resource "azurerm_windows_web_app" "web_app" {
  name                = "wa-${var.project}-${var.environment}-${var.location}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  site_config {
    application_stack {
      current_stack  = try(var.site_config.runtime_stack, "dotnet")
      dotnet_version = try(var.site_config.dotnet_version, "v7.0")
    }    
  }  
}