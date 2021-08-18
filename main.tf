locals {
  firewall_pip_name = var.fw_public_ip != "" ? var.fw_public_ip : "${var.firewall_name}-pip"
}

resource "azurerm_public_ip" "fw_ip" {
  name                = local.firewall_pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_firewall" "az_firewall" {
  name                = var.firewall_name
  location            = var.location 
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  firewall_policy_id  = var.azfw_policy_id
  tags                = var.tags

# The Subnet used for the Firewall must have the name ```AzureFirewallSubnet``` and the subnet mask must be at least a /26
  ip_configuration {
    name                 = "${var.firewall_name}-fw-ip"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.fw_ip.id       # The Public IP must have a Static allocation and Standard sku.
  }

  # management_ip_configuration
  # virtual_hub
  # Additional Public IPs
}


