provider "azurerm" {
  features {}
}

locals {
  location    = "UK South"
  module_tag  = {"module" = basename(abspath(path.module))}
  env_tag     = {"environment" = "non-Prod"}
  any_tags     = {"tag1" = "tag1Value", "tag2" = "tag2Value", "location" = local.location, "projectCode" = "PR12345"}
  tags        = merge(local.module_tag, local.env_tag, local.any_tags)
}

# Lookup Network for Firewall
data "azurerm_subnet" "azure_firewall" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = "core-vnet"
  resource_group_name  = "network"
}

# Create additional Public IP - No1
resource "azurerm_public_ip" "fw_additional_ip01" {
  name                = "fw-pip01"
  resource_group_name = "network"
  location            = local.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

# Create additional Public IP - No2
resource "azurerm_public_ip" "fw_additional_ip02" {
  name                = "fw-pip02"
  resource_group_name = "network"
  location            = local.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}


# Deploy new Azure Firewall from the Module.
module "azfirewall" {
  source = "../../"
  #  source  = "andrewCluey/azfirewall/azurerm"
  #  version = "2.0.0"

  resource_group_name = "network"
  location            = local.location
  subnet_id           = data.azurerm_subnet.azure_firewall.id
  environment         = "non-prod"

  additional_public_ips = [
    {
      name                 = azurerm_public_ip.fw_additional_ip01.name
      public_ip_address_id = azurerm_public_ip.fw_additional_ip01.id
    },
    {
      name                 = azurerm_public_ip.fw_additional_ip02.name
      public_ip_address_id = azurerm_public_ip.fw_additional_ip02.id
    }
  ]

  tags = local.tags
}