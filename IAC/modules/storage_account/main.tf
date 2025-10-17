resource "azurerm_storage_account" "storage" {
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  min_tls_version               = "TLS1_2"
  is_hns_enabled                = true
  public_network_access_enabled = false

  identity {
    type         = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }

  customer_managed_key {
    key_vault_key_id          = var.key_vault_key_id
    user_assigned_identity_id = var.user_assigned_identity_id
  }

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

  # ✅ Ensure mandatory tags are present
  tags = merge(
    var.tags,
    {
      Env         = var.env
      Owner       = "cloud-team" # adjust to your org’s policy
      CostCenter  = "12345"      # adjust to your org’s policy
      Application = "my-app"     # adjust if required
    }
  )
}
