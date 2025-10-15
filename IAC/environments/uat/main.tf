module "keyvault" {
  source              = "../../modules/keyvault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  aad_client_secret_value = var.aad_client_secret_value
}

module "app_service" {
  source                = "../../modules/app_service"
  app_service_plan_name = var.app_service_plan_name
  app_service_name      = var.app_service_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  app_settings          = {
    ENV               = var.env
    AAD_CLIENT_SECRET = module.keyvault.aad_client_secret_name
  }
  subnet_id             = var.subnet_id
}

module "cosmosdb" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.keyvault.key_vault_key_id
}

module "acr" {
  source              = "../../modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.keyvault.key_vault_key_id
}

module "storage_account" {
  source               = "../../modules/storage_account"
  storage_account_name = var.storage_account_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  key_vault_key_id     = module.keyvault.key_vault_key_id
}

module "eventhub" {
  source              = "../../modules/eventhub"
  eventhub_namespace  = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
}

module "uat_outputs" {
  source                = "../../modules/outputs"
  keyvault_id           = module.keyvault.key_vault_id
  cosmosdb_name         = module.cosmosdb.cosmosdb_name
  acr_name              = module.acr.acr_name
  storage_account_name  = module.storage_account.storage_account_name
  eventhub_namespace    = module.eventhub.eventhub_namespace
  eventhub_name         = module.eventhub.eventhub_name
  app_service_name      = module.app_service.app_service_name
}
