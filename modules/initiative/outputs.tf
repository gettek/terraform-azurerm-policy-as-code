output id {
  description = "The Id of the Policy Set Definition"
  value       = azurerm_policy_set_definition.set.id
}

output name {
  description = "The name of the Policy Set Definition"
  value       = var.initiative_name
}

output parameters {
  description = "The combined parameters of the Policy Set Definition"
  value       = local.all_parameters
}

output metadata {
  description = "The metadata of the Policy Set Definition"
  value       = local.metadata
}

output initiative {
  description = "The complete Policy Initiative resource node"
  value       = azurerm_policy_set_definition.set
}
