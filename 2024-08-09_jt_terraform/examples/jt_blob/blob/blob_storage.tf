resource "azurerm_storage_account" "this" {
  name                      = var.blob_storage.name
  resource_group_name       = var.blob_storage.resource_group_name
  location                  = var.blob_storage.location
  account_tier              = var.blob_storage.account_tier
  account_replication_type  = var.blob_storage.account_replication_type
  shared_access_key_enabled = var.blob_storage.shared_access_key_enabled

  dynamic "blob_properties" {
    for_each = each.value.blob_properties != null ? [each.value.blob_properties] : []
    content {
      delete_retention_policy {
        days = blob_properties.value.delete_retention_policy_days
      }
      versioning_enabled  = blob_properties.value.versioning_enabled
      change_feed_enabled = blob_properties.value.change_feed_enabled
      restore_policy {
        days = blob_properties.value.restore_policy_days
      }
      container_delete_retention_policy {
        days = blob_properties.value.container_delete_retention_policy_days
      }
    }
  }

  tags = var.blob_storage.tags
}

resource "azurerm_storage_management_policy" "storage_management_policy" {
  for_each = { for key, value in var.blob_storage : key => value.management_policy_rules if value.management_policy_rules != null }

  storage_account_id = azurerm_storage_account.this[each.key].id

  dynamic "rule" {
    for_each = each.value
    content {
      name    = rule.value.name
      enabled = true

      filters {
        prefix_match = rule.value.prefix_match
        blob_types   = ["blockBlob"]
      }

      actions {
        base_blob {
          tier_to_cool_after_days_since_modification_greater_than    = var.blob_storage.base_blob.tier_to_cool_days
          tier_to_archive_after_days_since_modification_greater_than = var.blob_storage.base_blob.tier_to_archive_days
          delete_after_days_since_modification_greater_than          = var.blob_storage.base_blob.delete_after_days_since_modification
        }

        dynamic "snapshot" {
          for_each = rule.value.snapshot_age != null ? [rule.value.snapshot_age] : []
          content {
            delete_after_days_since_creation_greater_than = snapshot.value
          }
        }

        dynamic "version" {
          for_each = rule.value.version_age != null ? [rule.value.version_age] : []
          content {
            delete_after_days_since_creation = version.value
          }
        }
      }
    }
  }
}
