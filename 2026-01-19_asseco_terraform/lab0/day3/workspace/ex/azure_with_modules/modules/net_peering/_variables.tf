variable "resource_group_name" {
  type = string
}

variable "name" {
  type = string
}

variable "networks" {
  type = map(object({
    name = string
    id   = string
  }))
}
