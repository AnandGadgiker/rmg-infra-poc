# Terraform Azure IAC - VNet-aware Full Modular Project

This project provisions Azure resources with support for integrating with existing VNet/subnet resources:
- 2 App Services (optional VNet integration via swift connection)
- 1 CosmosDB
- 1 ACR
- 1 Storage Account
- 1 Event Hub (optional Private Endpoint into provided subnet)

Instructions:
1. Replace the placeholder subnet ID in `env/dev/dev.tfvars` and `env/uat/uat.tfvars` with your existing subnet resource id, e.g.:
   /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RG_NAME>/providers/Microsoft.Network/virtualNetworks/<VNET_NAME>/subnets/<SUBNET_NAME>

2. From environment folder run:
   terraform init
   terraform plan -var-file=dev.tfvars
   terraform apply -var-file=dev.tfvars

Notes:
- App Service VNet integration uses Swift connection which requires the subnet to be delegated for Microsoft.Web or meet Azure requirements. Validate with your network/team before running.
- Event Hub private endpoint will be created only if `eventhub_subnet_id` is provided.
