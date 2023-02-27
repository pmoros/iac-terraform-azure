terraform {
  required_version = "=1.3.9"
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = var.appserviceplan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type = "Windows"
  sku_name = var.sku_name
}

resource "azurerm_app_service" "appservice" {
  name                = var.appservice_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.appserviceplan.id

    site_config {
    always_on = true
    dotnet_framework_version = "v6.0" # does not allow v7.0
    scm_type = "LocalGit"
    use_32_bit_worker_process = true
  }

}

resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "example-ipconfig"
    subnet_id                     = var.subnet_id # Add to a subnet
    private_ip_address_allocation = "Dynamic"
  }
}

