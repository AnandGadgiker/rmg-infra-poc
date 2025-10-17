env                     = "dev"
location                = "eastus"
resource_group_name     = "rg-dev"
key_vault_name          = "kv-dev-rmg-0017"
storage_account_name    = "stdev0013"
subnet_id               = "/subscriptions/1caa3d80-14f8-4775-b51b-247372d730b0/resourceGroups/rg-aiforce-hub-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-aiforce-rmgpoc-uksouth-001/subnets/sbnt-pep-uksouth-001"
cosmosdb_name           = "cosmos-dev-0017"
eventhub_namespace      = "ehns-dev-001"
eventhub_name           = "events-dev-001"
aad_client_secret_value = "REDACTED"

# New: ACRs
acr_names = [
  "acr1dev001-dev",
  "acr2dev001-dev",
  "acr3dev001-dev"
]

# New: Container Apps
container_app_names = [
  "app1-dev01",
  "app2-dev02",
  "app3-dev03"
]

tags = {
  Owner = "rmg-devops"
  Env   = "dev"
}
