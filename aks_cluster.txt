resource "azurerm_resource_group" "aks_rg" {
  name     = "RG2"
  location = "East US"  # Adjust according to your region
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.snet_name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_storage_account" "storage" {
  name                     = "aksdepstore"
  resource_group_name      = azurerm_resource_group.aks_rg.name
  location                 = azurerm_resource_group.aks_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "state_container" {
  name                  = "terraform-state"
  storage_account_id    = azurerm_storage_account.storage.id  # Corrected to use storage_account_id
  container_access_type = "private"
}

data "azurerm_container_registry" "acr" {
  name                = "aksautoacr"               # Name of the existing ACR
  resource_group_name = azurerm_resource_group.aks_rg.name  # Resource group containing the ACR
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                     = "aksautodeploy"
  location                 = azurerm_resource_group.aks_rg.location
  resource_group_name      = azurerm_resource_group.aks_rg.name
  dns_prefix               = "aks-cluster"
  private_cluster_enabled  = true

  linux_profile {
    admin_username = "awd"
    ssh_key {
      key_data = file("~/.ssh/id_rsa.pub") # Ensure this file exists or replace with a valid public key
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = 3
    vm_size         = "Standard_D2as_v4"
    type            = "VirtualMachineScaleSets"
    max_pods        = 20
    vnet_subnet_id  = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.env
  }

  network_profile {
    dns_service_ip    = "10.1.0.10"        # Adjusted based on the new service CIDR
    load_balancer_sku = "standard"
    network_plugin    = "azure"
    network_policy    = "calico"
    service_cidr      = "10.1.0.0/16"      # Updated to avoid overlapping with existing subnets
  }
}

resource "azurerm_role_assignment" "aks_to_acr" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}

