terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  required_version = ">=1.2.7, <=1.3.6"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Get local IP address
data "http" "icanhazip" {
   url = "https://ipv4.icanhazip.com/"
}

module "oauth2" {
  source = "./modules/oauth2"

  apim_oauth2_scope = "apim"
}