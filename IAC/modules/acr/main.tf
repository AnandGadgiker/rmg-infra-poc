
resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  data_endpoint_enabled         = true

  georeplications {
  location                = "East US"
  zone_redundancy_enabled = true
}

  identity {
    type = "SystemAssigned"
  }

  encryption {
    key_vault_key_id   = var.key_vault_key_id
    identity_client_id   = azurerm_container_registry.acr.identity[0].principal_id
  }

}
