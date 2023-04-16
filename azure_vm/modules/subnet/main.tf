resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = var.azurerm_resource_group_name
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "dmz" {
  name                 = "dmz-subnet"
  resource_group_name  = var.azurerm_resource_group_name
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
}