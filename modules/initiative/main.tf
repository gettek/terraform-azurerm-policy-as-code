resource "terraform_data" "set_replace" {
  input = local.replace_trigger
}

resource "azurerm_policy_set_definition" "set" {
  name                = var.initiative_name
  display_name        = var.initiative_display_name
  description         = var.initiative_description
  management_group_id = var.management_group_id
  policy_type         = "Custom"
  metadata            = jsonencode(local.metadata)
  parameters          = length(local.parameters) > 0 ? jsonencode(local.parameters) : null

  dynamic "policy_definition_reference" {
    for_each = local.member_properties
    content {
      policy_definition_id = policy_definition_reference.value.id
      reference_id         = policy_definition_reference.value.reference
      parameter_values = length(policy_definition_reference.value.parameters) > 0 ? jsonencode({
        for k in keys(policy_definition_reference.value.parameters) :
        k => {
          value = k == "effect" && var.merge_effects == false ? "[parameters('${k}_${policy_definition_reference.value.reference}')]" : var.merge_parameters == false ? "[parameters('${k}_${policy_definition_reference.value.reference}')]" : "[parameters('${k}')]"
        }
      }) : null
      policy_group_names = []
    }
  }

  lifecycle {
    replace_triggered_by = [terraform_data.set_replace]
  }

  timeouts {
    read = "10m"
  }
}
