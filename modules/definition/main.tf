resource "azurerm_policy_definition" "def" {
  name         = local.policy_name
  display_name = local.display_name
  description  = local.description
  policy_type  = "Custom"
  mode         = local.mode

  management_group_id = var.management_group_id

  metadata    = jsonencode(local.metadata)
  parameters  = length(local.parameters) > 0 ? jsonencode(local.parameters) : null
  policy_rule = jsonencode(local.policy_rule)

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    read = "10m"
  }
}
