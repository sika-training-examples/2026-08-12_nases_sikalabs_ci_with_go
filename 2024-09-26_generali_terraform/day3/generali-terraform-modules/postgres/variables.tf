variable "name" {
  description = "Name of the network"
  type        = string
}

variable "location" {
  description = "Location of the network"
  type        = string
  default     = "westeurope"
}

variable "sku_name" {
  description = "The SKU name of the PostgreSQL Server"
  type        = string
  default     = "GP_Standard_D4s_v3"
}

variable "postgres_version" {
  description = "The PostgreSQL Server version"
  type        = string
  default     = "16"
}

variable "storage_mb" {
  description = "The storage capacity of the PostgreSQL Server"
  type        = number
  default     = 32768
}

variable "backup_retention_days" {
  description = "The backup retention days for the PostgreSQL Server"
  type        = number
  default     = 7
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for the PostgreSQL Server"
  type        = bool
  default     = true
}

variable "firewall_rules" {
  description = "The firewall rules for the PostgreSQL Server"
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {}
}

variable "databases" {
  description = "The databases to create on the PostgreSQL Server"
  type        = list(string)
  default     = []
}
