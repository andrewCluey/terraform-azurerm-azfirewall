
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }

  tags = merge(var.tags, local.module_tag)
  name_prefix = "azfw-${var.environment}"
}

resource "azurerm_public_ip" "fw_ip" {
  name                = "${local.name_prefix}-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  tags                = local.tags
}

resource "azurerm_firewall" "az_firewall" {
  name                = "${local.name_prefix}-fw"
  location            = var.location 
  resource_group_name = var.resource_group_name
  tags                = local.tags

  ip_configuration {
    name                 = "${local.name_prefix}-fw-ip"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.fw_ip.id
  }
}




