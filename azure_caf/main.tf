terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # version = "=3.0.0"
    }
  }
}

provider "azurerm" {

  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

module "caf" {

  providers = {
    azurerm.vhub = azurerm.vhub
  }

  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  global_settings = var.global_settings
  resource_groups = var.resource_groups
  keyvaults       = var.keyvaults

  compute = {
    virtual_machines = var.virtual_machines
  }

  networking = {
    public_ip_addresses = var.public_ip_addresses
    vnets               = var.vnets
  }
}

