output id {
  description = "The Policy Assignment Id"
  value       = local.assignment.id
}

output principal_id {
  description = "The Principal Id of this Policy Assignment's Managed Identity if type is SystemAssigned"
  value       = try(local.assignment.identity[0].principal_id, null)
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

output definition_references {
  description = "The Member Definition Reference Ids"
  value       = try(var.initiative.policy_definition_reference, [])
}
