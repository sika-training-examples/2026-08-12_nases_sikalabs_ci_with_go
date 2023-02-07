variable "prefix" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}

variable "zone_id" {
  type = string
}

variable "vms" {
  type = map(any)
}

variable "db_count" {
  type = number
}
