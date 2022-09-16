output "id" {
  description = "The Id of the Policy Definition"
  value       = data.azurerm_policy_definition.def_builtin.id
}

output "name" {
  description = "The display name of the Policy Definition"
  value       = var.display_name
}

output "rules" {
  description = "The rules of the Policy Definition"
  value       = data.azurerm_policy_definition.def_builtin.policy_rule
}

output "parameters" {
  description = "The parameters of the Policy Definition"
  value       = data.azurerm_policy_definition.def_builtin.parameters
}

output "metadata" {
  description = "The metadata of the Policy Definition"
  value       = data.azurerm_policy_definition.def_builtin.metadata
}

output "definition" {
  description = "Policy definition from data source"
  value = {
    id          = data.azurerm_policy_definition.def_builtin.id
    name        = var.display_name
    description = data.azurerm_policy_definition.def_builtin.description
    metadata    = data.azurerm_policy_definition.def_builtin.metadata
    parameters  = data.azurerm_policy_definition.def_builtin.parameters
    policy_rule = data.azurerm_policy_definition.def_builtin.policy_rule
  }
}
