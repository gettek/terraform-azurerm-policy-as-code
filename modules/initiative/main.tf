resource azurerm_policy_set_definition set {
  name         = var.initiative_name
  display_name = var.initiative_display_name
  description  = var.initiative_description
  policy_type  = "Custom"

  management_group_name = var.management_group_name

  dynamic "policy_definition_reference" {
    for_each = [for d in var.member_definitions : {
      id         = d.id
      parameters = jsondecode(d.parameters)
    }]

    content {
      policy_definition_id = policy_definition_reference.value.id
      parameter_values = jsonencode({
        for k in keys(policy_definition_reference.value.parameters) :
        k => { value = "[parameters('${k}')]" }
      })
    }
  }

  parameters = local.all_parameters
  metadata   = local.metadata

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      metadata
    ]
  }

  timeouts {
    read = "10m"
  }
}
