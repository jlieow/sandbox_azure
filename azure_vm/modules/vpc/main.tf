resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name
}