resource "azurerm_key_vault" "this" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "premium"
  purge_protection_enabled    = true
  soft_delete_enabled         = true
  soft_delete_retention_days  = 90
}

resource "azurerm_key_vault_key" "cmk" {
  name         = "${var.key_vault_name}-cmk"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048
}

resource "azurerm_key_vault_secret" "aad_client_secret" {
  name         = "AAD_CLIENT_SECRET"
  value        = var.aad_client_secret_value
  key_vault_id = azurerm_key_vault.this.id
}

output "key_vault_id" {
  value = azurerm_key_vault.this.id
}

output "key_vault_key_id" {
  value = azurerm_key_vault_key.cmk.id
}

output "aad_client_secret_name" {
  value = azurerm_key_vault_secret.aad_client_secret.name
}
