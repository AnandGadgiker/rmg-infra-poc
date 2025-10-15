IAC/
├── README.md
├── backend.tf
├── providers.tf
├── modules/
│   ├── acr/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── app_service/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── cosmosdb/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── eventhub/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── keyvault/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── outputs/
│   │   ├── main.tf
│   │   └── variables.tf
│   └── storage_account/
│       ├── main.tf
│       └── variables.tf
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── dev.tfvars
│   └── uat/
│       ├── backend.tf
│       ├── providers.tf
│       ├── main.tf
│       ├── variables.tf
│       └── uat.tfvars
