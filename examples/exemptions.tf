# Resource exemption on multiple key vaults
module "exemption_configure_asc_initiative" {
  source               = "..//modules/exemption"
  name                 = "Onboard subscription to ASC Exemption"
  display_name         = "Exempted while testing"
  description          = "Excludes subscription from ASC onboarding during development"
  scope                = data.azurerm_subscription.current.id
  policy_assignment_id = module.org_mg_configure_asc_initiative.id
  policy_definition_reference_ids = [
    "69908db02e3d4a578d03",
    "1428ed118e4dcca5e747"
  ]
  exemption_category = "Waiver"
  expires_on         = "2023-05-25"
}
