terraform {
  backend "azurerm" {
    resource_group_name   = "RG2"                # Name of your Resource Group
    storage_account_name  = "aksdepstore"         # Name of your Storage Account
    container_name        = "terraform-state"      # Name of the container that holds the Terraform state
    key                   = "terraform.tfstate"    # The file name for storing the state
  }
}
