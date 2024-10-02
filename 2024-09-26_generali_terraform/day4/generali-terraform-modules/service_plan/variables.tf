variable "name" {
  description = "Name of the network"
  type        = string
}

variable "location" {
  description = "Location of the network"
  type        = string
  default     = "westeurope"
}

variable "os_type" {
  description = "OS type of the service plan"
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "SKU name of the service plan"
  type        = string
}
