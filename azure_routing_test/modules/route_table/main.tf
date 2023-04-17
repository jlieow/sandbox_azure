resource "azurerm_subnet_route_table_association" "example" {
  subnet_id      = var.azurerm_subnet_id
  route_table_id = azurerm_route_table.example.id
}

resource "azurerm_route_table" "example" {
  name                          = "example-route-table"
  location                      = var.azurerm_resource_group_location
  resource_group_name           = var.azurerm_resource_group_name

  tags = {
    environment = "Production"
  }
}

resource "azurerm_route" "example" {
  name                      = "route_1"
  resource_group_name       = var.azurerm_resource_group_name
  route_table_name          = azurerm_route_table.example.name
  address_prefix            = "10.0.1.5/32"
  next_hop_type             = "VirtualAppliance"
  next_hop_in_ip_address    = "10.0.1.4"
}