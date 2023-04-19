data "azurerm_firewall" "example" {
  name                = "hub-commonsvcs-001-fw"
  resource_group_name = "hub-rg"
}

resource "azurerm_firewall_policy_rule_collection_group" "example" {
  name               = "Network-UAT-Rule-Collection-Group"
  firewall_policy_id = data.azurerm_firewall.example.firewall_policy_id
  priority           = 600
  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 600
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["10.0.0.1"]
      destination_addresses = ["192.168.1.1", "192.168.1.2"]
      destination_ports     = ["80", "1000-2000"]
    }
  }
}