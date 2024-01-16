output "id" {
  description = "The Id of the Policy Definition"
  value       = local.definition_id
}

output "name" {
  description = "The name of the Policy Definition"
  value       = var.policy_name
}

output "rules" {
  description = "The rules of the Policy Definition"
  value       = local.policy_rule
}

output "parameters" {
  description = "The parameters of the Policy Definition"
  value       = local.parameters
}

output "metadata" {
  description = "The metadata of the Policy Definition"
  value       = local.metadata
}

output "definition" {
  description = "The combined Policy Definition resource node"
  value = {
    id                  = local.definition_id
    name                = local.policy_name
    display_name        = local.display_name
    description         = local.description
    mode                = local.mode
    management_group_id = var.management_group_id
    metadata            = jsonencode(local.metadata)
    parameters          = jsonencode(local.parameters)
    policy_rule         = jsonencode(local.policy_rule)
  }
}
