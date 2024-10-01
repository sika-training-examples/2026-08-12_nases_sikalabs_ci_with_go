variable "env" {
  description = "Environment"
  type        = string

  validation {
    condition     = contains(["prod", "stage", "dev"], var.env)
    error_message = "The environment must be one of 'prod', 'stage', or 'dev'."
  }
}

variable "suffix" {
  description = "Suffix"
  type        = string
}

variable "firewall_rules" {
  description = "Postgres Firewall rules"
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
}

variable "replicas" {
  description = "Number of app replicas"
  type        = number
  default     = 1
}
