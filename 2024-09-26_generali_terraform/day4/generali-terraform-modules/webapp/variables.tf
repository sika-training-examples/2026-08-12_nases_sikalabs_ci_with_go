variable "name" {
  description = "Name of the network"
  type        = string
}

variable "location" {
  description = "Location of the network"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "service_plan_id" {
  description = "ID of the service plan"
  type        = string
}

variable "docker_image_name" {
  description = "Name of the Docker image"
  type        = string

}

variable "docker_registry_url" {
  description = "URL of the Docker registry"
  type        = string
}

variable "env" {
  description = "Environment variables for Docker container"
  type        = map(string)
  default     = {}
}

variable "worker_count" {
  description = "Number of workers"
  type        = number
  default     = 1
}
