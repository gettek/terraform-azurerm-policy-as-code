output id {
  description = "The Id of the Policy Exemption"
  value       = local.exemption_resource_node.id
}

output output_content {
  description = "The Content of the Outputs of the ARM Template Deployment"
  value       = jsondecode(local.exemption_resource_node.output_content)
}
