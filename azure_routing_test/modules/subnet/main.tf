resource "azurerm_subnet" "a" {
  name                 = "subnet_a"
  resource_group_name  = var.azurerm_resource_group_name
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "b" {
  name                 = "subnet_b"
  resource_group_name  = var.azurerm_resource_group_name
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "c" {
  name                 = "subnet_c"
  resource_group_name  = var.azurerm_resource_group_name
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
}