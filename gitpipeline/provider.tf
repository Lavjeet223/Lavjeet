terraform {
  required_version = ">= 1.0" 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
  #  backend "azurerm" {
  #   resource_group_name = "BackendRG"
  #   storage_account_name = "lavjeetbackendstg"
  #   container_name = "tfstate"
  #   key = "lavjeet.tfstate"
  # }
}

provider "azurerm" {
  features {}
  client_id       = var.client_id
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

variable "client_id" {}
variable "tenant_id" {}
variable "subscription_id" {}