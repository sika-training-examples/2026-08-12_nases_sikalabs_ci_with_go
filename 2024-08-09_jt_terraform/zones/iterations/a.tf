locals {
  TERRAFORM_STATE_DEFAULT = {
    resource_group_name       = module.resource_groups_connectivity.resource_group_names["tfstate"]
    shared_access_key_enabled = true
    management_policy_rules = [
      {
        name         = "tfstate_versions_rule"
        prefix_match = ["tfstate/"]
        version_age  = 7
      }
    ]
    tags = {
      environment = "dev"
    }
    containers = [
      { name = "tfstate", container_access_type = "private" }
    ]
    logs_to_monitor            = ["StorageRead", "StorageWrite", "StorageDelete"]
    metrics_to_monitor         = ["Capacity", "Transaction"]
    log_analytics_workspace_id = "/subscriptions/7bf66bb3-bd8e-4b84-bb28-3c71cf088150/resourceGroups/jtfgtest-mgmt/providers/Microsoft.OperationalInsights/workspaces/jtfgtest-la"
  }
}

module "azure_blob_storage_tfstate_connectivity" {
  source = "../../modules/azure_blob_storage"

  providers = { azurerm = azurerm.connectivity }

  blob_storage = {
    "jtfgtesttfstateconnect" = merge(local.TERRAFORM_STATE_DEFAULT, {
      location : "westus2",
    }),
    "jtfgtesttfstateconnect" = merge(local.TERRAFORM_STATE_DEFAULT, {
      location : "westeu2",
    }),
  }
}

module "azure_blob_storage_tfstate_identity" {
  source = "../../modules/azure_blob_storage"

  providers = { azurerm = azurerm.identity }

  blob_storage = {
    "jtfgtesttfstateidentity" = merge(local.TERRAFORM_STATE_DEFAULT, {
      location : "westeu2",
    }),
  }
}

module "azure_blob_storage_tfstate_identity" {
  source = "../../modules/azure_blob_storage"

  providers = { azurerm = azurerm.identity }

  blob_storage = merge(local.TERRAFORM_STATE_DEFAULT, {
    name : "jtfgtesttfstateidentity",
    location : "westeu2",
    shared_access_key_enabled : true,
  })
}


