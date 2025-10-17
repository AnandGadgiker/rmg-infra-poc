IAC/
├── backend.tf
├── providers.tf
├── versions.tf
├── modules/
│   ├── keyvault/
│   │   ├── main.tf
│	│	├── outputs.tf
│   │   └── variables.tf
│   ├── storage_account/
│   │   ├── main.tf
│ 	│ 	├── outputs.tf
│   │   └── variables.tf
│   ├── app_service/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── acr/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── cosmosdb/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── eventhub/
│   │   ├── main.tf
│   │   └── variables.tf
│   └── outputs/
│       ├── main.tf
│       └── variables.tf
└── env/
    ├── dev/
	│	├─backend.tf
    │   ├── main.tf
    │   ├── variables.tf
    │   └── dev.tfvars
    └── uat/
		├─backend.tf
        ├── main.tf
        ├── variables.tf
        └── uat.tfvars
