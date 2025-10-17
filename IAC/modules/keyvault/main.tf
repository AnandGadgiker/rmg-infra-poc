# Get current Terraform SP info
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
# Terraform SP Access Policy
# -------------------------------
resource "azurerm_key_vault_access_policy" "terraform_sp" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  # Minimum permissions for CMK creation & usage
  key_permissions = [
    "Get",
    "List",
    "Create",
    "Delete",
    "Recover",
    "Purge",
    "Encrypt",
    "Decrypt",
    "Sign",
    "Verify"
  ]

  # Secrets are optional; remove if unused
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]
}

# Optional: Provider identity (if you want another SP or MI to access KV)
resource "azurerm_key_vault_access_policy" "provider_identity" {
  count        = var.provider_object_id != null ? 1 : 0
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.provider_object_id

  key_permissions    = ["Get", "List", "Encrypt", "Decrypt"]
  secret_permissions = ["Get", "List"]
}

# -------------------------------
# Wait for policy propagation
# -------------------------------
resource "null_resource" "wait_for_policy" {
  provisioner "local-exec" {
    command = "sleep ${var.policy_propagation_delay}"
  }

  depends_on = [
    azurerm_key_vault_access_policy.terraform_sp,
    azurerm_key_vault_access_policy.provider_identity
  ]
}

# -------------------------------
# Customer Managed Key (CMK)
# -------------------------------
resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt"]

  depends_on = [null_resource.wait_for_policy]
}

# -------------------------------
# Outputs
# -------------------------------
output "key_vault_key_id" {
  value = azurerm_key_vault_key.cmk.id
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}
