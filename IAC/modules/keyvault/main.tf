data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "uami" {
  name                = "uami-${var.env}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  # ✅ Required for CMK scenarios
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  public_network_access_enabled = true

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags

  # Access for the Terraform identity
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Recover", "Purge",
      "GetRotationPolicy", "SetRotationPolicy"
    ]
    secret_permissions  = ["Get", "List", "Set", "Delete"]
    storage_permissions = ["Get", "List", "Set"]
  }

  # Access for the UAMI
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.uami.principal_id

    key_permissions = [
      "Get", "List", "Encrypt", "Decrypt",
      "GetRotationPolicy", "SetRotationPolicy"
    ]
  }
}

# Delay to allow access policies to propagate
resource "time_sleep" "wait_for_policy" {
  depends_on      = [azurerm_key_vault.kv]
  create_duration = "60s"
}

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

  depends_on = [time_sleep.wait_for_policy]
}
