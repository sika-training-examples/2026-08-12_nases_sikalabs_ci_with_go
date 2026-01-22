variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "private_ip_address" {
  type = string
}

variable "public_ip_address_id" {
  type    = string
  default = null
}

variable "network_security_group_ids" {
  type    = list(string)
  default = []
}

variable "size" {
  type = string
}

variable "public_key" {
  type = string
}
