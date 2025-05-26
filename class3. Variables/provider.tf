terraform {
  backend "azurerm" {
    resource_group_name  = "lavbackendrg"
    storage_account_name = "lavbackendstg"
    container_name       = "lavbackendcont"
    key                  = "tillvariable.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "92a5423a-800b-4586-a593-3cfb81ba9a44"
}
