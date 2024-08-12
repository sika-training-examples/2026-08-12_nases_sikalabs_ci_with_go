variable "blob_storage" {
  description = "Details of the storage accounts and their containers"
  type = map(object({
    resource_group_name       = string
    location                  = string
    account_tier              = string
    account_replication_type  = string
    shared_access_key_enabled = optional(bool, false)
    blob_properties = optional(object({
      delete_retention_policy_days           = number
      versioning_enabled                     = bool
      change_feed_enabled                    = bool
      restore_policy_days                    = number
      container_delete_retention_policy_days = number
    }))
    management_policy_rules = optional(list(object({
      name         = string
      prefix_match = list(string)
      base_blob = optional(object({
        tier_to_cool_days                    = number
        tier_to_archive_days                 = number
        delete_after_days_since_modification = number
      }))
      snapshot_age = optional(number)
      version_age  = optional(number)
    })))
    tags = map(string)
    containers = list(object({
      name                  = string
      container_access_type = string
    }))
    logs_to_monitor            = list(string)
    metrics_to_monitor         = list(string)
    log_analytics_workspace_id = string
  }))
  default = {

  }
}

variable "container_details" {
  type = map(object({
    containers = list(object({
      name                  = string
      container_access_type = string
    }))
  }))
  default = {

  }
}
