resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  admin_enabled       = false

  encryption {
    status           = "enabled"
    key_vault_key_id = var.key_vault_key_id
  }

  dynamic "georeplications" {
    for_each = var.geo_replication_location == null ? [] : [var.geo_replication_location]
    content {
      location                = georeplications.value
      zone_redundancy_enabled = false
    }
  }
}
