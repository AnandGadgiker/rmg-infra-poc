# Key Vault
resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  purge_protection_enabled = true

  tags = var.tags
}

# Optional: Customer Managed Key (CMK)
resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt"]
}

# Outputs
output "key_vault_key_id" {
  value = azurerm_key_vault_key.cmk.id
}
