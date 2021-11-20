output id {
  description = "The Policy Assignment Id"
  value       = local.assignment_id
}

output identity_id {
  description = "The Managed Identity block containing Principal Id & Tenant Id of this Policy Assignment if type is SystemAssigned"
  value       = local.principal_id
}
