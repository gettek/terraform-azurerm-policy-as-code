output id {
  description = "The Id of the Policy Exemption"
  value       = local.exemption_resource_nodes[*].id
}

output exemption_resource_nodes {
  description = "The Policy Exemption resource node(s)"
  value       = local.exemption_resource_nodes
}
