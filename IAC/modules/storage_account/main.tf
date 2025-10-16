resource "azurerm_storage_account" "storage" {
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  min_tls_version               = "TLS1_2"
  is_hns_enabled                = true
  public_network_access_enabled = false

  # Merge mandatory tags enforced by Azure Policy with user-provided tags
  tags = merge(
    var.tags,
    {
      Owner       = "rmg-devops" # mandatory
      Environment = var.env      # mandatory policy tag
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
}

# Private Endpoint (optional)
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

  # Wait for storage account to be ready
  depends_on = [azurerm_storage_account.storage]
}
