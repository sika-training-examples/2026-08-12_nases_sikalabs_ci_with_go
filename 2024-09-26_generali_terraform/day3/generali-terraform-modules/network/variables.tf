variable "name" {
  description = "Name of the network"
  type        = string
}

variable "location" {
  description = "Location of the network"
  type        = string
  default     = "westeurope"
}

variable "address_space" {
  description = "Address space of the network"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets of the network"
  type        = map(list(string))
  default     = {}
}
