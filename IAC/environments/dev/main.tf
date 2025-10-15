# -------------------
# Key Vault Module
# -------------------
module "keyvault" {
  source              = "../../modules/keyvault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  object_id           = var.object_id
}

# -------------------
# App Service Plan
# -------------------
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

# -------------------
# Key Vault Secrets
# -------------------
data "azurerm_key_vault_secret" "aad_client_secret" {
  name         = "AAD_CLIENT_SECRET"
  key_vault_id = module.keyvault.key_vault_id
}

# -------------------
# App Service Module
# -------------------
module "app_service" {
  source              = "../../modules/app_service"
  app_service_name    = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  subnet_id           = var.subnet_id

  app_settings = {
    ENV               = "dev"
    AAD_CLIENT_SECRET = data.azurerm_key_vault_secret.aad_client_secret.value
  }

  depends_on = [module.keyvault]
}

# -------------------
# Cosmos DB Module
# -------------------
module "cosmosdb" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.keyvault.key_vault_key_id
}

# -------------------
# Azure Container Registry Module
# -------------------
module "acr" {
  source              = "../../modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = module.keyvault.key_vault_key_id
}

# -------------------
# Storage Account Module
# -------------------
module "storage_account" {
  source               = "../../modules/storage_account"
  storage_account_name = var.storage_account_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  key_vault_key_id     = module.keyvault.key_vault_key_id
}

# -------------------
# Event Hub Module
# -------------------
module "eventhub" {
  source              = "../../modules/eventhub"
  eventhub_namespace  = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
}

# -------------------
# Outputs Module
# -------------------
module "dev_outputs" {
  source = "../../modules/outputs"

  keyvault_id          = module.keyvault.key_vault_id
  keyvault_cmk_id      = module.keyvault.key_vault_key_id
  cosmosdb_name        = module.cosmosdb.cosmosdb_name
  acr_name             = module.acr.acr_name
  storage_account_name = module.storage_account.storage_account_name
  eventhub_namespace   = module.eventhub.eventhub_namespace
  eventhub_name        = module.eventhub.eventhub_name
}
