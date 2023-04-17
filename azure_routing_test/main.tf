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

module "vm_a" {
  source = "./modules/vm"

  prefix = "vm_a"
  azurerm_resource_group_location = data.azurerm_resource_group.jerome_testing_rg.location
  azurerm_resource_group_name = data.azurerm_resource_group.jerome_testing_rg.name

  azurerm_subnet_id = module.subnet.subnet_a_id
}

module "vm_b" {
  source = "./modules/vm"

  prefix = "vm_b"
  azurerm_resource_group_location = data.azurerm_resource_group.jerome_testing_rg.location
  azurerm_resource_group_name = data.azurerm_resource_group.jerome_testing_rg.name

  azurerm_subnet_id = module.subnet.subnet_b_id
}

module "vm_c" {
  source = "./modules/vm"

  prefix = "vm_c"
  azurerm_resource_group_location = data.azurerm_resource_group.jerome_testing_rg.location
  azurerm_resource_group_name = data.azurerm_resource_group.jerome_testing_rg.name

  azurerm_subnet_id = module.subnet.subnet_c_id
}

module "route_table" {
  source = "./modules/route_table"

  azurerm_resource_group_location = data.azurerm_resource_group.jerome_testing_rg.location
  azurerm_resource_group_name = data.azurerm_resource_group.jerome_testing_rg.name

  azurerm_subnet_id = module.subnet.subnet_a_id

}