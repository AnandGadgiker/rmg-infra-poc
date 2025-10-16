# Key Vault
resource "azurerm_key_vault" "kv" {
  name                     = var.key_vault_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = var.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = true

  # Access policies for Terraform SP
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.terraform_sp_object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Encrypt",
      "Decrypt",
      "Sign",
      "Verify"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]

    certificate_permissions = [
      "Get",
      "List"
    ]
  }

  tags = var.tags
}

# AAD Client Secret
resource "azurerm_key_vault_secret" "aad_client_secret" {
  name         = "aad-client-secret"
  value        = var.aad_client_secret_value
  key_vault_id = azurerm_key_vault.kv.id
}

# Customer Managed Key (CMK)
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

output "aad_client_secret_name" {
  value = azurerm_key_vault_secret.aad_client_secret.name
}
