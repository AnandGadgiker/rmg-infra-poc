location              = "East US"
resource_group_name   = "dev-rg" # or "uat-rg"
app_service_plan_name = "dev-app-plan"
app_service_name      = "dev-app-service"
app_settings = {
  "ENV" = "dev"
}
cosmosdb_name         = "dev-cosmosdb"
acr_name              = "devacr"
storage_account_name  = "devstorageacct"
eventhub_namespace    = "dev-namespace"
eventhub_name         = "dev-hub"
subnet_id             = "/subscriptions/<sub-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/subnet2"