resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  data_endpoint_enabled         = true
  zone_redundancy_enabled       = true

  # Only add georeplication if it's explicitly set and different from primary location
  dynamic "georeplications" {
    for_each = var.geo_replication_location != null && var.geo_replication_location != var.location ? [1] : []
    content {
      location                = var.geo_replication_location
      zone_redundancy_enabled = true
    }
  }

  identity {
    type = "SystemAssigned"
  }

  encryption {
    key_vault_key_id   = var.key_vault_key_id
    identity_client_id = null
  }

  tags = var.tags
}

output "principal_id" {
  value = azurerm_container_registry.acr.identity[0].principal_id
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "login_server" {
  value = azurerm_container_registry.acr.login_server
}
