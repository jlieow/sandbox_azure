output "azurerm_subnet_id" {
    value = azurerm_subnet.example.id
}

output "dmz_subnet_id" {
    value = azurerm_subnet.dmz.id
}