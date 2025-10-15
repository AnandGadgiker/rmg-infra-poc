# Common settings
location            = "East US"
resource_group_name = "dev-rg"
key_vault_name      = "kv-dev-rmg"

# App Service
app_service_plan_name = "dev-app-plan"
app_service_name      = "dev-app-service"
app_settings = {
  "ENV" = "dev"
  "AAD_CLIENT_SECRET" = "aad-client-secret" # Name of the secret in Key Vault
}

# CosmosDB
cosmosdb_name = "dev-cosmosdb"

# Azure Container Registry
acr_name = "devacr"

# Storage Account
storage_account_name = "devstorageacct"

# EventHub
eventhub_namespace = "dev-namespace"
eventhub_name      = "dev-hub"

# Networking
subnet_id = "/subscriptions/1caa3d80-14f8-4775-b51b-247372d730b0/resourceGroups/rg-aiforce-hub-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-aiforce-rmgpoc-uksouth-001/subnets/sbnt-pep-uksouth-001"

# Azure AD Authentication (used in App Service Key Vault references)
auth_client_id     = "replace-with-your-client-id"
auth_client_secret = "replace-with-your-client-secret"
auth_issuer_url    = "https://sts.windows.net/189de737-c93a-4f5a-8b68-6f4ca9941912/"
