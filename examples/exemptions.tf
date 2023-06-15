# Subscription Scope Resource Exemption
module "exemption_subscription_diagnostics_settings" {
  source               = "..//modules/exemption"
  name                 = "Subscription Diagnostic Settings Exemption"
  display_name         = "Exempted while testing"
  description          = "Excludes subscription from configuring diagnostics settings"
  scope                = data.azurerm_subscription.current.id
  policy_assignment_id = module.org_mg_platform_diagnostics_initiative.id
  exemption_category   = "Waiver"
  expires_on           = "2025-05-25"

  # use member_definition_names for simplicity when policy_definition_reference_ids are unknown
  member_definition_names = [
    "deploy_subscription_diagnostic_setting"
  ]
}
