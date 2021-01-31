output id {
  description = "The Policy Assignment Id"
  value       = azurerm_policy_assignment.set.id
}

output identity_id {
  description = "The Managed Identity block containing Principal Id & Tenant Id of this Policy Assignment if type is SystemAssigned"
  value       = azurerm_policy_assignment.set.identity[0].principal_id
}
