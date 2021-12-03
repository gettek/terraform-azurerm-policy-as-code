# Resource exemption on multiple key vaults
module "exemption_configure_asc_initiative" {
  source   = "..//modules/exemption"
  providers = {
    azurerm = azurerm.team_a
  }
  name                            = "Onboard subscription to ASC Exemption"
  scope                           = "/subscriptions/${var.team_a_subscription_id}"
  policy_assignment_id            = module.org_mg_configure_asc_initiative.id
  policy_definition_reference_ids = [
    "6d237bfef483fbb3308d",
    "652d1284813c442a7e95"
  ]
  exemption_category              = "Waiver"
  expires_on                      = "2022-05-31"
  display_name                    = "Exempted while testing"
  description                     = "Excludes subscription from ASC onboarding during development"
}

output "policy_definition_reference" {
  value = module.org_mg_configure_asc_initiative.initiative.policy_definition_reference
}

