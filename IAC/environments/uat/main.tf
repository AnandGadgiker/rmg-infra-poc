##############################
# 1️⃣ Key Vault Module
##############################
module "keyvault" {
  source              = "../../modules/keyvault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

##############################
# 2️⃣ App Service Plan
##############################
resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Standard"
    size = "S1"
  }
}

##############################
# 3️⃣ App Service
##############################
data "azurerm_key_vault_secret" "aad_client_secret" {
  name         = "AAD_CLIENT_SECRET"
  key_vault_id = module.keyvault.key_vault_id
}

module "app_service" {
  source                = "../../modules/app_service"
  app_service_name      = var.app_service_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  app_service_plan_id   = azurerm_app_service_plan.asp.id

  app_settings = {
    ENV               = "uat"
    AAD_CLIENT_SECRET = data.azurerm_key_vault_secret.aad_client_secret.value
  }

  depends_on = [module.keyvault] # optional, environment-level dependency
}

##############################
# 4️⃣ Cosmos DB
##############################
module "cosmosdb" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.keyvault.key_vault_key_id
}

##############################
# 5️⃣ ACR
##############################
module "acr" {
  source              = "../../modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.keyvault.key_vault_key_id
}

##############################
# 6️⃣ Storage Account
##############################
module "storage_account" {
  source                = "../../modules/storage_account"
  storage_account_name  = var.storage_account_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  key_vault_key_id      = module.keyvault.key_vault_key_id
}

##############################
# 7️⃣ Event Hub
##############################
module "eventhub" {
  source              = "../../modules/eventhub"
  eventhub_namespace  = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
}

##############################
# 8️⃣ Outputs
##############################
module "uat_outputs" {
  source = "../../modules/outputs"

  keyvault_id          = module.keyvault.key_vault_id
  keyvault_cmk_id      = module.keyvault.key_vault_key_id
  cosmosdb_name        = module.cosmosdb.cosmosdb_name
  acr_name             = module.acr.acr_name
  storage_account_name = module.storage_account.storage_account_name
  eventhub_namespace   = module.eventhub.eventhub_namespace
  eventhub_name        = module.eventhub.eventhub_name
}
