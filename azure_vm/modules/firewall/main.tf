resource "azurerm_public_ip" "firewall" {
  name                = "AgwPublicIp1"
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name
  allocation_method   = "Static"
  sku = "Standard"

  tags = {
    Name = "AgwPublicIp1"
  }
}

resource "azurerm_firewall" "example" {
  name                = "testfirewall"
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.dmz_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}