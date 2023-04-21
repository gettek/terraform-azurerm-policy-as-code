output "id" {
  description = "The Policy Assignment Id"
  value       = local.assignment.id
}

output "identity_id" {
  description = "The Managed Identity block containing Principal Id & Tenant Id of this Policy Assignment if type is SystemAssigned"
  value       = try(local.assignment.identity[0].principal_id, null)
}

output "remediation_id" {
  description = "The Id of the remediation task"
  value       = local.remediation_id
}

output "role_definition_ids" {
  description = "The List of Role Definition Ids assignable to the managed identity"
  value       = local.role_definition_ids
}
