data "azurerm_subscription" "current" {}

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
    for_each = local.policy_definition_reference

    content {
      policy_definition_id = policy_definition_reference.value.policy_definition_id
      reference_id         = policy_definition_reference.value.reference_id
      parameter_values     = policy_definition_reference.value.parameter_values
      policy_group_names   = []
    }
  }

  lifecycle {
    replace_triggered_by = [terraform_data.set_replace]
  }

  timeouts {
    read = "10m"
  }
}
