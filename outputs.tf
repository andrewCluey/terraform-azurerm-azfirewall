output "fw_name" {
  description = "The name assigned to the new firewall"
  value       = azurerm_firewall.az_firewall.name
}

output "fw_id" {
  description = "The ID of the new firewall"
  value       = azurerm_firewall.az_firewall.id
}