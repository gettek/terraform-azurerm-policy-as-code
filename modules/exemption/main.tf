resource "azurerm_management_group_template_deployment" "management_group_exemption" {
  count               = local.exemption_scope.mg
  name                = local.deployment_name
  location            = var.location
  management_group_id = var.scope
  parameters_content  = jsonencode(local.parameters_content)
  template_content    = local.exemptions_template
}

resource "azurerm_subscription_template_deployment" "subscription_exemption" {
  count               = local.exemption_scope.sub
  name                = local.deployment_name
  location            = var.location
  parameters_content  = jsonencode(local.parameters_content)
  template_content    = local.exemptions_template
}

resource "azurerm_resource_group_template_deployment" "resource_group_exemption" {
  count               = local.exemption_scope.rg
  name                = local.deployment_name
  resource_group_name = split("/", var.scope)[4]
  parameters_content  = jsonencode(local.parameters_content)
  template_content    = local.exemptions_template
  deployment_mode     = "Incremental"
}

resource "azurerm_resource_group_template_deployment" "resource_exemption" {
  count               = local.exemption_scope.resource
  name                = local.deployment_name
  resource_group_name = split("/", var.scope)[4]
  parameters_content  = jsonencode(local.parameters_content)
  template_content    = local.exemptions_template
  deployment_mode     = "Incremental"
}
