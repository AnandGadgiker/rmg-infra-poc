terraform {
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_keys_on_destroy = true
      recover_soft_deleted_keys          = true
    }
  }
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Key Vault
module "kv" {
  source              = "../../modules/keyvault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  env                 = var.env
  tags                = var.tags
}

# Storage
module "stg" {
  source                    = "../../modules/storage_account"
  storage_account_name      = var.storage_account_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  env                       = var.env
  key_vault_key_id          = module.kv.key_vault_key_id
  user_assigned_identity_id = module.kv.user_assigned_identity_id
  tags                      = var.tags
}

# App Service
module "app_service" {
  source                = "../../modules/app_service"
  app_service_plan_name = var.app_service_plan_name
  app_service_name      = var.app_service_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  subnet_id             = var.subnet_id
  app_settings = {
    ENV = var.env
  }
  aad_client_secret_value = var.aad_client_secret_value
}

# Cosmos DB
module "cosmos" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  key_vault_key_id    = module.kv.key_vault_key_id
  env                 = var.env
}

# ACR
module "acr" {
  source                   = "../../modules/acr"
  acr_name                 = var.acr_name
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  key_vault_key_id         = module.kv.key_vault_key_id
  geo_replication_location = null
}

# Event Hub
module "eh" {
  source              = "../../modules/eventhub"
  eventhub_namespace  = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = var.subnet_id
}

# Outputs aggregator
# Since infra modules don't have outputs, pass direct attributes from resources created in the KV module
# We need to replicate KV resources in root to reference them; the simplest approach is to output required attributes
# directly by reading the resource attributes in root where created (alternatively add minimal outputs in KV module).

# Re-declare references to KV resources created in module: we can't directly access them unless the module exports them.
# Therefore, for a "no outputs in infra modules" approach, we must create the UAMI and KV in root OR add outputs to KV.
# To keep modules clean AND achieve wiring, we'll add minimal outputs in KV. This is the only non-optional change.

# Replace earlier note: add these outputs in modules/keyvault (necessary for wiring)
# output "key_vault_id"                    = azurerm_key_vault.kv.id
# output "key_vault_key_id"                = azurerm_key_vault_key.cmk.id
# output "key_vault_uri"                   = azurerm_key_vault.kv.vault_uri
# output "user_assigned_identity_id"       = azurerm_user_assigned_identity.uami.id
# output "user_assigned_identity_principal_id" = azurerm_user_assigned_identity.uami.principal_id

module "dev_outputs" {
  source = "../../modules/outputs"

  # Key Vault
  key_vault_name   = var.key_vault_name
  key_vault_id     = module.kv.key_vault_id
  key_vault_key_id = module.kv.key_vault_key_id
  key_vault_uri    = module.kv.key_vault_uri

  # UAMI
  user_assigned_identity_id           = module.kv.user_assigned_identity_id
  user_assigned_identity_principal_id = module.kv.user_assigned_identity_principal_id

  # Storage
  storage_account_name = var.storage_account_name
  # If storage module has no outputs, and we need ID later, consider adding minimal output there.
  # For now, we only expose the name.
  storage_account_id = module.stg.storage_account_id

  # Cosmos DB
  cosmosdb_name = var.cosmosdb_name

  # ACR
  acr_name = var.acr_name

  # Event Hub
  eventhub_namespace = var.eventhub_namespace
  eventhub_name      = var.eventhub_name

  # App Service
  app_service_name             = var.app_service_name
  app_service_default_hostname = "${var.app_service_name}.azurewebsites.net"
}
