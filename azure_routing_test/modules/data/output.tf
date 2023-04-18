output "firewall_private_ip" {
  value = data.azurerm_firewall.example.ip_configuration[0].private_ip_address
}