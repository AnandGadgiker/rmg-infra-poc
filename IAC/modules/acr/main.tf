
resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  data_endpoint_enabled         = true

  georeplication_locations = [
    "East US",
    "West Europe"
  ]

  identity {
    type = "SystemAssigned"
  }

  encryption {
    key_vault_key_id     = azurerm_key_vault_key.acr_key.id
    identity_client_id   = azurerm_container_registry.acr.identity[0].principal_id
  }

  retention_policy {
    enabled = true
    days    = 30
  }
}
