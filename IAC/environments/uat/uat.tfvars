# Common settings
location            = "East US"
resource_group_name = "uat-rg"
key_vault_name      = "kv-uat-rmg"

# App Service
app_service_plan_name = "uat-app-plan"
app_service_name      = "uat-app-service"
app_settings = {
  "ENV" = "uat"
  "AAD_CLIENT_SECRET" = "aad-client-secret" # Name of the secret in Key Vault
}

# CosmosDB
cosmosdb_name = "uat-cosmosdb"

# Azure Container Registry
acr_name = "uatacr"

# Storage Account
storage_account_name = "uatstorageacct"

# EventHub
eventhub_namespace = "uat-namespace"
eventhub_name      = "uat-hub"

# Networking
subnet_id = "/subscriptions/1caa3d80-14f8-4775-b51b-247372d730b0/resourceGroups/rg-aiforce-hub-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-aiforce-rmgpoc-uksouth-001/subnets/sbnt-pep-uksouth-001"

# Azure AD Authentication (used in App Service Key Vault references)
auth_client_id     = "replace-with-your-client-id"
auth_client_secret = "replace-with-your-client-secret"
auth_issuer_url    = "https://sts.windows.net/189de737-c93a-4f5a-8b68-6f4ca9941912/"
