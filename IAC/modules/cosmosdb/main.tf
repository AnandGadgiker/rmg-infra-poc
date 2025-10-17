resource "azurerm_cosmosdb_account" "db" {
  name                = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  automatic_failover_enabled        = true
  multiple_write_locations_enabled  = false
  is_virtual_network_filter_enabled = true
  public_network_access_enabled     = false
  local_authentication_disabled     = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  identity {
    type = "SystemAssigned"
  }

  # Link to Key Vault key (CMK)
  key_vault_key_id = var.key_vault_key_id
}
