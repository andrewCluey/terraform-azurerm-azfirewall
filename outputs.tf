output "fw_name" {
  description = "The name assigned to the new firewall"
  value       = azurerm_firewall.az_firewall.name
}

output "fw_id" {
  description = "The ID of the new Azure Firewall"
  value       = azurerm_firewall.az_firewall.id
}

output "object" {
  description = "Output the full object"
  value       = azurerm_firewall.az_firewall
}

output "firewall_private_ip" {
  value = azurerm_firewall.az_firewall.ip_configuration.0.private_ip_address
}