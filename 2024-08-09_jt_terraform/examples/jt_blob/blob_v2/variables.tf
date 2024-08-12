variable "blob_storage" {
  description = "Details of the storage accounts and their containers"
  type = object({
    resource_group_name                    = string
    location                               = string
    account_tier                           = string
    account_replication_type               = string
    shared_access_key_enabled              = optional(bool, false)
    delete_retention_policy_days           = optional(number, 7)
    versioning_enabled                     = bool
    change_feed_enabled                    = optional(bool, false)
    restore_policy_days                    = optional(number, 5)
    container_delete_retention_policy_days = optional(number, 7)
    management_policy_rules = optional(list(object({
      name         = string
      prefix_match = list(string)
      base_blob = optional(object({
        tier_to_cool_days                    = number
        tier_to_archive_days                 = number
        delete_after_days_since_modification = number
        }), {
        tier_to_cool_days                    = 30
        tier_to_archive_days                 = 60
        delete_after_days_since_modification = 90
      })
      snapshot_age = optional(number)
      version_age  = optional(number)
    })))
    tags = map(string)
    containers = list(object({
      name                  = string
      container_access_type = string
    }))
    # logs_to_monitor     = list(string)
    # metrics_to_monitor = list(string)
    # log_analytics_workspace_id = string
  })
}

variable "containers" {
  description = "Map of storage account containers, where the key is the container name and the value is a map of container details"
  type = map(object({
    container_access_type = string
  }))
}
