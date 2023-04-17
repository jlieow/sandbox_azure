locals {
    frontend_port_name = "frontend_port_name"
    frontend_ip_configuration_name = "frontend_ip_configuration_name"
    backend_address_pool_name = "backend_address_pool_name"
    http_setting_name = "http_setting_name"
    listener_name = "listener_name"
    request_routing_rule_name = "request_routing_rule_name"
}

resource "azurerm_public_ip" "agw" {
  name                = "AgwPublicIp1"
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name
  allocation_method   = "Static"
  sku = "Standard"

  tags = {
    Name = "AgwPublicIp1"
  }
}

resource "azurerm_application_gateway" "network" {
  name                = "example-appgateway"
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.dmz_subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agw.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    # path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}