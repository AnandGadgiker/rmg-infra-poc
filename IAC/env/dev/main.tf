# Key Vault
module "kv" {
  source        = "../../modules/keyvault"
  key_vault_name = var.key_vault_name
  location       = var.location
  resource_group_name = var.resource_group_name
  tenant_id      = var.tenant_id
  object_id      = var.object_id
}

# App Service Plan + App Service
module "app_svc" {
  source                = "../../modules/app_service"
  app_service_plan_name = var.app_service_plan_name
  app_service_name      = var.app_service_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  app_settings          = var.app_settings
  subnet_id             = var.subnet_id
  app_service_plan_id   = var.app_service_plan_id
}

# Cosmos DB
module "cosmos" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.kv.key_vault_key_id
}

# Azure Container Registry
module "acr" {
  source              = "../../modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.kv.key_vault_key_id
}

# Storage Account
module "stg" {
  source               = "../../modules/storage_account"
  storage_account_name = var.storage_account_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  key_vault_key_id     = module.kv.key_vault_key_id
}

# Event Hub
module "eh" {
  source              = "../../modules/eventhub"
  eventhub_namespace  = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
}

# Outputs
module "dev_outputs" {
  source                = "../../modules/outputs"
  keyvault_id           = module.kv.key_vault_id
  cosmosdb_name         = module.cosmos.cosmosdb_name
  acr_name              = module.acr.acr_name
  storage_account_name  = module.stg.storage_account_name
  eventhub_namespace    = module.eh.eventhub_namespace
  eventhub_name         = module.eh.eventhub_name
  app_service_name      = module.app_service.app_service_name
}
