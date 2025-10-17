data "azurerm_client_config" "current" {}

# User Assigned Managed Identity for CMK usage
resource "azurerm_user_assigned_identity" "uami" {
  name                = "uami-${var.env}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = var.sku_name
  purge_protection_enabled      = false
  public_network_access_enabled = true

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags

  # Access policy for Terraform SP
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.terraform_sp_object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Recover", "Purge",
      "GetRotationPolicy", "SetRotationPolicy"
    ]
    secret_permissions  = ["Get", "List", "Set", "Delete"]
    storage_permissions = ["Get", "List", "Set"]
  }

  # Access policy for provider identity (if set)
  dynamic "access_policy" {
    for_each = var.provider_object_id != null ? [var.provider_object_id] : []
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = access_policy.value

      key_permissions = [
        "Get", "List", "Encrypt", "Decrypt",
        "GetRotationPolicy", "SetRotationPolicy"
      ]
      secret_permissions  = ["Get", "List"]
      storage_permissions = []
    }
  }

  # Access policy for UAMI used by storage account
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.uami.principal_id

    key_permissions = [
      "Get", "List", "Encrypt", "Decrypt",
      "GetRotationPolicy", "SetRotationPolicy", "Delete"
    ]
    secret_permissions  = []
    storage_permissions = []
  }
}

# Customer Managed Key (CMK)
resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
}
