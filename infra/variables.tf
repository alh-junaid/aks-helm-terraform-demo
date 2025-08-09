variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "dd8ab0e1-d33e-4d66-94e8-7ede9facd8ed"
}
variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "West US"
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "my-resource-group"
}
variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "my-aks"
}
variable "dns_prefix" {
  description = "DNS prefix for AKS cluster"
  type        = string
  default     = "aks-demo"
}
variable "vm_size" {
  description = "Size of the VMs for node pools"
  type        = string
  default     = "Standard_B2ms"
}
variable "default_node_count" {
  description = "Number of nodes in default node pool"
  type        = number
  default     = 1
}
variable "additional_node_pool_name" {
  description = "Name of additional node pool"
  type        = string
  default     = "pool"
}
variable "additional_node_count" {
  description = "Number of nodes in additional node pool"
  type        = number
  default     = 1
}