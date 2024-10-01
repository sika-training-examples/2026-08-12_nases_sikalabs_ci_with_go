variable "name" {
  type        = string
  description = "The name of the AKS cluster"
}

variable "location" {
  type        = string
  description = "The location of the AKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version of the AKS cluster"
}

variable "vm_size" {
  type        = string
  description = "The VM size of the AKS cluster"
}

variable "node_count" {
  type        = number
  description = "The number of nodes in the AKS cluster"
}

variable "tags_common" {
  type = map(string)
}
