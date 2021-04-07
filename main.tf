locals {
  name_prefix = "azfw"
}

resource "azurerm_public_ip" "fw_ip" {
  name                = "${local.name_prefix}-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_firewall" "az_firewall" {
  name                = "${local.name_prefix}-fw"
  location            = var.location 
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  firewall_policy_id  = var.azfw_policy_id
  tags                = var.tags

# The Subnet used for the Firewall must have the name ```AzureFirewallSubnet``` and the subnet mask must be at least a /26
  ip_configuration {
    name                 = "${local.name_prefix}-fw-ip"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.fw_ip.id       # The Public IP must have a Static allocation and Standard sku.
  }

  dynamic "ip_configuration" {
    for_each = var.additional_public_ips
    content {
      name                 = ip_configuration.value.name
      public_ip_address_id = ip_configuration.value.public_ip_address_id
    }
  }

  # management_ip_configuration
  # virtual_hub
}


