variable "name" {
  type = string
}

variable "image" {
  type    = string
  default = "debian-11-x64"
}

variable "size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "region" {
  type    = string
  default = "fra1"
}

variable "ssh_keys" {
  type = list(string)
}

variable "zone_id" {
  type = string
}
