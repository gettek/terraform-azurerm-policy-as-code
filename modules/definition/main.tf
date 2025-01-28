resource "random_string" "set_replace" {
  length  = 3
  special = false

  keepers = {
    parameters = length(local.parameters) > 0 ? md5(jsonencode(local.parameters)) : "asdf"
  }
}


resource "azurerm_policy_definition" "def" {
  name         = join("_", [substr(local.policy_name, 0, 60), random_string.set_replace.result])
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
