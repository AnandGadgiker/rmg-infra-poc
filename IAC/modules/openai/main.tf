resource "azurerm_cognitive_account" "openai" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "OpenAI"
  sku_name            = var.sku_name
  public_network_access_enabled = false
}

resource "azurerm_private_endpoint" "openai_pe" {
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id  = azurerm_cognitive_account.openai.id
    subresource_names               = ["account"]
    is_manual_connection            = false
  }
}

output "openai_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}
