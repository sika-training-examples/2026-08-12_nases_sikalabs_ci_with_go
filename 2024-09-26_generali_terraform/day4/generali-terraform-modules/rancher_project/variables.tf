variable "name" {
  description = "The name of the project"
  type        = string
}

variable "cluster_id" {
  description = "The ID of the cluster to create the project in"
  type        = string
}


variable "registry" {
  description = "The container registry to use for the project"
  type        = string
}

variable "registry_username" {
  description = "The username for the container registry"
  type        = string
}

variable "registry_password" {
  description = "The password for the container registry"
  type        = string
}

variable "project_limit_cpu" {
  description = "The CPU limit for the project"
  type        = string
  default     = "2000m"
}

variable "project_limit_memory" {
  description = "The memory limit for the project"
  type        = string
  default     = "2000Mi"
}

variable "project_limit_storage" {
  description = "The storage limit for the project"
  type        = string
  default     = "2Gi"
}

variable "namespace_default_limit_cpu" {
  description = "The default CPU limit for namespaces in the project"
  type        = string
  default     = "2000m"
}

variable "namespace_default_limit_memory" {
  description = "The default memory limit for namespaces in the project"
  type        = string
  default     = "500Mi"
}

variable "namespace_default_limit_storage" {
  description = "The default storage limit for namespaces in the project"
  type        = string
  default     = "1Gi"
}
