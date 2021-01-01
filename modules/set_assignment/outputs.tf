output id {
  description = "The Policy Assignment Id"
  value       = azurerm_policy_assignment.set.id
}

output identity {
  description = "The Managed Identity block containing Principal Id & Tenant Id of this Policy Assignment if type is SystemAssigned, referenced with *.principal_id[0] or *.tenant_id[0]"
  value       = azurerm_policy_assignment.set.identity
}
