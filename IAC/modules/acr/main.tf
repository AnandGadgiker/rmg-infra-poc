resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  data_endpoint_enabled         = true
  zone_redundancy_enabled       = true

  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
  }

  # Assign a system identity for this ACR
  identity {
    type = "SystemAssigned"
  }

  # Enable encryption using customer-managed key
  encryption {
    key_vault_key_id = var.key_vault_key_id
    # 👇 Use the same identity assigned above for encryption.
    identity_client_id = null
  }
}

# Output principal ID (so other modules can reference it safely)
output "principal_id" {
  value = azurerm_container_registry.acr.identity[0].principal_id
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "login_server" {
  value = azurerm_container_registry.acr.login_server
}
