##################
# Guest Configuration
##################

# Onboarding Prerequisites
locals {
  guest_config_prereqs = [
    "add_system_identity_when_none_prerequisite",
    "add_system_identity_when_user_prerequisite",
    "deploy_extension_linux_prerequisite",
    "deploy_extension_windows_prerequisite",
  ]
}

module "guest_config_prereqs" {
  source           = "..//modules/definition"
  for_each         = toset(local.guest_config_prereqs)
  policy_name      = each.value
  policy_category  = "Guest Configuration"
  management_group = data.azurerm_management_group.org.name
}

module "guest_config_prereqs_initiative" {
  source                  = "..//modules/initiative"
  initiative_name         = "guest_config_prereqs_initiative"
  initiative_display_name = "[GC]: Deploys Guest Config Prerequisites"
  initiative_description  = "Deploys and configures Windows and Linux VM Guest Config Prerequisites"
  initiative_category     = "Guest Configuration"
  management_group        = data.azurerm_management_group.org.name

  member_definitions = [
    for gcp in module.guest_config_prereqs :
    gcp.definition
  ]
}
