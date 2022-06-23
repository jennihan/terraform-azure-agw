output "app_gateway_name" {
  value = var.app_gateway_name
}

output "app_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.main.id
}

output "app_gateway_private_ip" {
  value = var.private_ip_address
}

output "app_gateway_location" {
  value = var.location
}

output "app_gateway_resource_group" {
  value = var.resource_group_name
}


