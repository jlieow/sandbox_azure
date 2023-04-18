data "azurerm_firewall" "example" {
  name                = "hub-commonsvcs-001-fw"
  resource_group_name = "hub-rg"
}