output "eventhub_namespace" {
  value       = azurerm_eventhub_namespace.eh_ns.name
  description = "Event Hub Namespace"
}

output "eventhub_name" {
  value       = azurerm_eventhub.eh.name
  description = "Event Hub Name"
}

output "eventhub_id" {
  value       = azurerm_eventhub.eh.id
  description = "ID of the Event Hub"
}
