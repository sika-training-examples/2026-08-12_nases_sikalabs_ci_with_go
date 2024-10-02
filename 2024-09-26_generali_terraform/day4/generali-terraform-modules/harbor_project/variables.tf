variable "project_name" {
  type = string
}

variable "public" {
  type    = bool
  default = false
}

variable "project_admins" {
  type    = list(string)
  default = []
}
