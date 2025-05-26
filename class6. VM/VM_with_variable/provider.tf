terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
  #  backend "azurerm" {
  #   resource_group_name = "lavbackendrg"
  #   storage_account_name = "lavbackendstg"
  #   container_name = "lavbackendcont"
  #   key = "lavjeet.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = "92a5423a-800b-4586-a593-3cfb81ba9a44"
}
