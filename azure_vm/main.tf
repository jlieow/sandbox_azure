terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  # required_version = ">=1.2.7, <=1.3.6"
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

data "azurerm_resource_group" "jerome_testing_rg" {
  name = "jerome-testing-rg"
}

module "vpc" {
  source = "./modules/vpc"

  azurerm_resource_group_location = data.azurerm_resource_group.jerome_testing_rg.location
  azurerm_resource_group_name = data.azurerm_resource_group.jerome_testing_rg.name
}

module "subnet" {
  source = "./modules/subnet"

  azurerm_resource_group_name = data.azurerm_resource_group.jerome_testing_rg.name
  azurerm_virtual_network_name = module.vpc.azurerm_virtual_network_name
}

module "vm" {
  source = "./modules/vm"

  prefix = "test"
  azurerm_resource_group_location = data.azurerm_resource_group.jerome_testing_rg.location
  azurerm_resource_group_name = data.azurerm_resource_group.jerome_testing_rg.name

  azurerm_subnet_id = module.subnet.azurerm_subnet_id
}

module "application_gateway" {
  source = "./modules/application_gateway"

  azurerm_resource_group_location = data.azurerm_resource_group.jerome_testing_rg.location
  azurerm_resource_group_name = data.azurerm_resource_group.jerome_testing_rg.name

  dmz_subnet_id = module.subnet.dmz_subnet_id
}