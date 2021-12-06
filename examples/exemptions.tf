# Resource exemption on multiple key vaults
module "exemption_configure_asc_initiative" {
  source = "..//modules/exemption"
  providers = {
    azurerm = azurerm.team_a
  }
  name                 = "Onboard subscription to ASC Exemption"
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  policy_assignment_id = module.org_mg_configure_asc_initiative.id
  policy_definition_reference_ids = [
    "6d237bfef483fbb3308d",
    "652d1284813c442a7e95"
  ]
  exemption_category = "Waiver"
  expires_on         = "2022-05-31"
  display_name       = "Exempted while testing"
  description        = "Excludes subscription from ASC onboarding during development"
}
