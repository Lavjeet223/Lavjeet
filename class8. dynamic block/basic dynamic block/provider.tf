terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
 }

provider "azurerm" {
  features {}
  subscription_id = "92a5423a-800b-4586-a593-3cfb81ba9a44"
}
