terraform {
  backend "azurerm" {
    resource_group_name  = "dev-tfstate-rg"
    storage_account_name = "gactfstatedemo1"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}