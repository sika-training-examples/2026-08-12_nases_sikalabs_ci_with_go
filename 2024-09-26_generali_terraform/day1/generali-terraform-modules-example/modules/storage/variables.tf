variable "name" {
  type        = string
  description = "The name of the storage account"
}

variable "location" {
  type        = string
  description = "The location of the storage account"
}

variable "tags_common" {
  type = map(string)
}

variable "containers" {
  type = map(object({
    container_access_type = string
  }))
  description = "The containers to create in the storage account"
  default     = {}
}
