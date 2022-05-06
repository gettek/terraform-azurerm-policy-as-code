# Resource exemption on multiple key vaults
module "exemption_configure_asc_initiative" {
  source               = "..//modules/exemption"
  name                 = "Onboard subscription to ASC Exemption"
  display_name         = "Exempted while testing"
  description          = "Excludes subscription from ASC onboarding during development"
  scope                = data.azurerm_client_config.current.id
  policy_assignment_id = module.org_mg_configure_asc_initiative.id
  policy_definition_reference_ids = [
    "6d237bfef483fbb3308d",
    "652d1284813c442a7e95"
  ]
  exemption_category = "Waiver"
  expires_on         = "2023-05-25"
}
