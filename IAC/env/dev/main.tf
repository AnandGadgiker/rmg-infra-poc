terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0"
    }
  }
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


# 1️⃣ Create Resource Group first
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Owner = "rmg-devops"
    Env   = var.env
  }
}

# 2️⃣ Key Vault
module "kv" {
  source              = "../../modules/keyvault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  env                 = var.env
  tags = merge(
    var.tags,
    {
      Owner = "rmg-devops"
    }
  )
}
# 3️⃣ App Service Plan + App Service
module "app_service" {
  source                = "../../modules/app_service"
  app_service_plan_name = var.app_service_plan_name
  app_service_name      = var.app_service_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  subnet_id             = var.subnet_id

  # Application settings
  app_settings = {
    ENV = var.env
  }
  aad_client_secret_value = var.aad_client_secret_value

  depends_on = [module.kv, module.stg]
}

# 4️⃣ Cosmos DB
module "cosmos" {
  source              = "../../modules/cosmosdb"
  cosmosdb_name       = var.cosmosdb_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  key_vault_key_id    = module.kv.key_vault_key_id
}

# 5️⃣ Azure Container Registry
module "acr" {
  source                   = "../../modules/acr"
  acr_name                 = var.acr_name
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  key_vault_key_id         = module.kv.key_vault_key_id
  geo_replication_location = null # optional
}

# 6️⃣ Storage Account
module "stg" {
  source                    = "../../modules/storage_account"
  storage_account_name      = var.storage_account_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  subnet_id                 = var.subnet_id
  env                       = var.env
  key_vault_key_id          = module.kv.key_vault_key_id
  user_assigned_identity_id = module.kv.user_assigned_identity_id
  tags = merge(
    var.tags,
    {
      Owner       = "rmg-devops"
      Criticality = "High" # mandatory per policy
    }
  )

  depends_on = [module.kv]
}

# 7️⃣ Event Hub
module "eh" {
  source              = "../../modules/eventhub"
  eventhub_namespace  = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = var.subnet_id
}

# 8️⃣ Outputs
# 8️⃣ Outputs
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

  # ACR
  acr_name = var.acr_name

  # Event Hub
  eventhub_namespace = var.eventhub_namespace
  eventhub_name      = var.eventhub_name

  # App Service
  app_service_name             = var.app_service_name
  app_service_default_hostname = "${var.app_service_name}.azurewebsites.net"
}
