terraform {
  required_version = "=1.3.9"
  backend "azurerm" {
    storage_account_name = "stpaulmorosdefault001"
    container_name       = "crterraformstate001"
    key                  = "global/resource-group"
    access_key           = "cri8Kac61+2I5usyQj2rOtf/baLjGLHtPXFxq9FOZc7DleKtcspPnJ74yl5UxiZI+7552kExcoT6+AStXYecSA=="
  }
}

provider "azurerm" {    
    features {}
}

resource "azurerm_resource_group" "rg-activity2-eastus" {
  name     = "rg-activity2-${var.location}"
  location = var.location
}