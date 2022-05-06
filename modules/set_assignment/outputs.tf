output id {
  description = "The Policy Assignment Id"
  value       = local.assignment_id
}

output identity_id {
  description = "The Managed Identity block containing Principal Id & Tenant Id of this Policy Assignment if type is SystemAssigned"
  value       = local.principal_id
}

output remediation_tasks {
  description = "The Remediation Task Ids and related Policy Definition Ids"
  value = [
    for rem in local.remediation_tasks :
    tomap({
      "id"                   = rem.id
      "policy_definition_id" = rem.policy_definition_id
    })
  ]
}
