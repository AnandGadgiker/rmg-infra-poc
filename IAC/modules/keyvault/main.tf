# Get the current identity (GitHub Action / Service Principal / Managed Identity)
data "azurerm_client_config" "current" {}

# Create Key Vault
resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7
  public_network_access_enabled = false

  # Grant access to the current identity
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = ["Get","List","Create","Update","Delete","Recover","Purge"]
    secret_permissions = ["Get","List","Set","Delete"]
  }
}

# Create a Customer Managed Key (CMK) in Key Vault
resource "azurerm_key_vault_key" "cmk" {
  name         = "${var.key_vault_name}-cmk"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt","decrypt","sign","verify","wrapKey","unwrapKey"]
}
