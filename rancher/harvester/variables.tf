# Variables for DO infrastructure module

variable "kubeconfig_path" {
  type        = string
  description = "Kubeconfig file path to connect to the Harvester cluster"
}

variable "kubecontext" {
  type        = string
  description = "Name of the kubernetes context to use to the Harvester cluster"
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
}

variable "namespace" {
  type        = string
  description = "Harvester namespace to deploy the VMs into"
  default     = "default"
}

variable "user_name" {
  type        = string
  description = "Name of the user"
}

variable "image_namespace" {
  type        = string
  description = "Namespace of the Harvester image to deploy the VMs into"
}

variable "image_name" {
  type        = string
  description = "Name of the Harvester image to deploy the VMs into"
}

variable "network_namespace" {
  type        = string
  description = "Namespace of the Harvester network to deploy the VMs into"
}

variable "network_name" {
  type        = string
  description = "Name of the Harvester network to deploy the VMs into"
}

variable "rancher_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for Rancher server cluster"
  default     = "v1.23.14+k3s1"
}

variable "cert_manager_version" {
  type        = string
  description = "Version of cert-manager to install alongside Rancher (format: 0.0.0)"
  default     = "1.10.0"
}

variable "rancher_version" {
  type        = string
  description = "Rancher server version (format: v0.0.0)"
  default     = "2.7.0"
}

variable "rancher_server_admin_password" {
  type        = string
  description = "Admin password to use for Rancher server bootstrap, min. 12 characters"
}


