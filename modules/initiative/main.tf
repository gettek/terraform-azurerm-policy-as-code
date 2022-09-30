resource azurerm_policy_set_definition set {
  name         = var.initiative_name
  display_name = var.initiative_display_name
  description  = var.initiative_description
  policy_type  = "Custom"

  management_group_id = var.management_group_id

  metadata   = jsonencode(local.metadata)
  parameters = length(local.parameters) > 0 ? jsonencode(local.parameters) : null

  dynamic policy_definition_reference {
    for_each = [for d in var.member_definitions : {
      id         = d.id
      ref_id     = replace(substr(title(replace(d.name, "/-|_|\\s/", " ")), 0, 64), "/\\s/", "")
      parameters = try(jsondecode(d.parameters), {})
      groups     = []
    }]

    content {
      policy_definition_id = policy_definition_reference.value.id
      reference_id         = policy_definition_reference.value.ref_id
      parameter_values = length(policy_definition_reference.value.parameters) > 0 ? jsonencode({
        for k in keys(policy_definition_reference.value.parameters) :
        k => {
          value = k == "effect" && var.merge_effects == false ? "[parameters('${format("%s_%s", k, policy_definition_reference.value.ref_id)}')]" : var.merge_parameters == false ? "[parameters('${format("%s_%s", k, policy_definition_reference.value.ref_id)}')]" :"[parameters('${k}')]"
        }
      }) : null
      policy_group_names = policy_definition_reference.value.groups
    }
  }

  timeouts {
    read = "10m"
  }
}
