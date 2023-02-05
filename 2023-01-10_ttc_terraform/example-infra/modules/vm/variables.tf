variable "name" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}

variable "size" {
  type    = string
  default = "s-1vcpu-2gb"
}

variable "image" {
  type    = string
  default = "debian-11-x64"
}

variable "region" {
  type    = string
  default = "fra1"
}
