output id {
  description = "The Id of the Policy Definition"
  value       = azurerm_policy_definition.def.id
}

output name {
  description = "The name of the Policy Definition"
  value       = var.policy_name
}

output rules {
  description = "The rules of the Policy Definition"
  value       = local.policy_rule
}

output parameters {
  description = "The parameters of the Policy Definition"
  value       = local.parameters
}

output metadata {
  description = "The metadata of the Policy Definition"
  value       = local.metadata
}

output definition {
  description = "The complete resource node of the Policy Definition"
  value       = azurerm_policy_definition.def
}
