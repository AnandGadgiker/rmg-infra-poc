variable "acr_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "tags" {
  type    = map(string)
  default = {}
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  admin_enabled       = false
  tags                = var.tags
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}