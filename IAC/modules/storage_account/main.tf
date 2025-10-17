resource "azurerm_storage_account" "storage" {
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  min_tls_version               = "TLS1_2"
  is_hns_enabled                = true
  public_network_access_enabled = false

  # Merge mandatory policy tags with user-provided tags
  tags = merge(
    var.tags,
    {
      Owner       = "rmg-devops"
      Env         = var.env
      Criticality = "High"
    }
  )

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 7
    }
  }

  sas_policy {
    expiration_period = "PT24H"
  }

  # Placeholder for CMK (required but ignored)
  customer_managed_key {}

  lifecycle {
    ignore_changes = [
      customer_managed_key,
    ]
  }
}

# Customer Managed Key linking Storage Account to Key Vault
resource "azurerm_storage_account_customer_managed_key" "stg_cmk" {
  storage_account_id = azurerm_storage_account.storage.id
  key_vault_key_id   = var.key_vault_key_id
}

# Private Endpoint
resource "azurerm_private_endpoint" "storage_pe" {
  name                = "storage-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "storage-priv-conn"
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
