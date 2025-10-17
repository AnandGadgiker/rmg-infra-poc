# Get current Terraform SP (the one running the pipeline)
data "azurerm_client_config" "current" {}

# -------------------------------
# Key Vault Resource
# -------------------------------
resource "azurerm_key_vault" "kv" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = var.sku_name
  soft_delete_enabled           = true
  purge_protection_enabled      = false
  public_network_access_enabled = true

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags
}

# -------------------------------
# Access Policy for Terraform SP
# -------------------------------
resource "azurerm_key_vault_access_policy" "terraform_sp" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.terraform_sp_object_id

  key_permissions = [
    "Get",
    "List",
    "Create",
    "Delete",
    "Recover",
    "Purge",
    "GetRotationPolicy",
    "SetRotationPolicy",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]

  storage_permissions = [
    "Get",
    "List",
    "Set"
  ]
}

# -------------------------------
# Optional Access Policy for Provider Identity (if exists)
# -------------------------------
resource "azurerm_key_vault_access_policy" "provider_identity" {
  count        = var.provider_object_id != null ? 1 : 0
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.provider_object_id

  key_permissions = [
    "Get",
    "List",
    "Encrypt",
    "Decrypt",
    "WrapKey",
    "UnwrapKey"
  ]
}

# -------------------------------
# Key Vault Key (CMK)
# -------------------------------
resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [azurerm_key_vault_access_policy.terraform_sp]
}
