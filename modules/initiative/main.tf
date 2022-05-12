resource azurerm_policy_set_definition set {
  name         = var.initiative_name
  display_name = var.initiative_display_name
  description  = var.initiative_description
  policy_type  = "Custom"

  management_group_id = var.management_group_id

  metadata   = local.metadata
  parameters = local.all_parameters

  dynamic policy_definition_reference {
    for_each = [for d in var.member_definitions : {
      id         = d.id
      ref_id     = substr(title(replace(d.name, "/-|_|\\s/", " ")), 0, 64)
      parameters = jsondecode(d.parameters)
      groups     = []
    }]

    content {
      policy_definition_id = policy_definition_reference.value.id
      reference_id         = replace(policy_definition_reference.value.ref_id, "/\\s/", "")
      parameter_values = jsonencode({
        for k in keys(policy_definition_reference.value.parameters) :
        k => { value = "[parameters('${k}')]" }
      })
      policy_group_names = policy_definition_reference.value.groups
    }
  }

  timeouts {
    read = "10m"
  }
}
