variable "env" {
  type        = string
  description = "The environment for the Azure Service account execution (e.g., 'dev', 'prod')"
  default     = "dev"  # You can set a default environment if needed, or leave it empty for required input
}

variable "location" {
  type        = string
  description = "Azure region for resource deployment (e.g., 'East US', 'South India')"
  default     = "East US"
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID for the Azure Service account execution"
  default     = "c1e955a2-1271-43d3-8915-0b1694890b54"  # Add your tenant ID here
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID for the Azure Service account execution"
  default     = "f913d422-f064-4ead-8628-97a3e44d570a" # Add your subscription ID here
}

variable "vnet_rg_name" {
  type        = string
  description = "Resource group name for the virtual network"
  default     = "RG2"  # Example resource group name
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network in Azure"
  default     = "vnetaks"  # Example virtual network name
}

variable "snet_name" {
  type        = string
  description = "Name of the subnet within the virtual network"
  default     = "snetaks"  # Example subnet name
}

variable "aks_rg_name" {
  type        = string
  description = "Resource group name for Azure Kubernetes Service"
  default     = "RG2"  # Example resource group name
}

variable "aks_name" {
  type        = string
  description = "Name of the Azure Kubernetes Service cluster"
  default     = "aksautodeploy"  # Example AKS cluster name
}

variable "aks_node_count" {
  type        = number
  description = "Number of nodes in the Azure Kubernetes Service cluster"
  default     = 2  # Default number of nodes
}

variable "aks_node_size" {
  type        = string
  description = "Size of the nodes in the Azure Kubernetes Service cluster (e.g., 'Standard_DS2_v2')"
  default     = "Standard_D2as_v4"  # Default node size
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
  default     = "aksautoacr"  # Example container registry name
}

variable "acr_rg" {
  type        = string
  description = "Resource group for the Azure Container Registry"
  default     = "RG2"  # Example resource group name
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for accessing Azure virtual machines"
  default     = ""  # Ensure this is updated with your actual SSH public key
}
