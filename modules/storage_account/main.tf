variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }

resource "azurerm_storage_account" "sa" {
  name                     = lower(format("%sstorage", var.name_prefix))
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_blob_public_access = false
  is_hns_enabled           = false
  tags                     = var.tags
}

output "storage_account_name" { value = azurerm_storage_account.sa.name }
output "storage_account_primary_blob_endpoint" { value = azurerm_storage_account.sa.primary_blob_endpoint }
