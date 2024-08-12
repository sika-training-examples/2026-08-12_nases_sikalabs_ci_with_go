variable "event_hub_namespace" {
  description = "Details of the Event Hub namespace"
  type = object({
    name                          = string
    sku                           = string
    capacity                      = number
    tags                          = map(string)
    public_network_access_enabled = bool
    event_hubs = map(object({
      partition_count   = number
      message_retention = number
    }))
    receiver_principal_ids = optional(list(string), [])
  })
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resources."
  type        = string
}
