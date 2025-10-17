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

# Cosmos DB
module "cosmos" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  key_vault_key_id    = module.kv.key_vault_key_id
  env                 = var.env
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

# -------------------------------
# New: Log Analytics Workspace
# -------------------------------
module "log_analytics" {
  source              = "../../modules/log_analytics"
  log_analytics_name  = "law-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# -------------------------------
# New: Container Apps Environment
# -------------------------------
resource "azurerm_container_app_environment" "cae" {
  name                       = "cae-${var.env}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = module.log_analytics.log_analytics_id
}

# -------------------------------
# New: 3 ACRs
# -------------------------------
module "acrs" {
  source              = "../../modules/acr"
  for_each            = toset(["acr1", "acr2", "acr3"])
  acr_name            = "${each.key}${var.env}rmg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# -------------------------------
# New: 3 Container Apps
# -------------------------------
module "container_apps" {
  source                       = "../../modules/container_app"
  for_each                     = toset(["app1", "app2", "app3"])
  app_name                     = "${each.key}-${var.env}"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.cae.id
  image                        = "${module.acrs[replace(each.key, "app", "acr")].acr_login_server}/${each.key}:latest"
  tags                         = var.tags
  log_analytics_workspace_id   = module.log_analytics.log_analytics_id
}

# -------------------------------
# Updated: Outputs aggregator
# -------------------------------
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
  storage_account_id   = module.stg.storage_account_id

  # Cosmos DB
  cosmosdb_name = var.cosmosdb_name

  # ACRs
  acr_name = "acr1-${var.env}, acr2-${var.env}, acr3-${var.env}" # optional summary

  # Event Hub
  eventhub_namespace = var.eventhub_namespace
  eventhub_name      = var.eventhub_name

  # Container Apps
  app_service_name             = "app1-${var.env}, app2-${var.env}, app3-${var.env}"
  app_service_default_hostname = "Not applicable (Container Apps)"
}
