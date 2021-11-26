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

module guest_config_prereqs {
  source                = "..//modules/definition"
  for_each              = toset(local.guest_config_prereqs)
  policy_name           = each.value
  policy_category       = "Guest Configuration"
  management_group_name = data.azurerm_management_group.org.name
}

module guest_config_prereqs_initiative {
  source                  = "..//modules/initiative"
  initiative_name         = "guest_config_prereqs_initiative"
  initiative_display_name = "[GC]: Deploys Guest Config Prerequisites"
  initiative_description  = "Deploys and configures Windows and Linux VM Guest Config Prerequisites"
  initiative_category     = "Guest Configuration"
  management_group_name   = data.azurerm_management_group.org.name

  member_definitions = [
    for gcp in module.guest_config_prereqs :
    gcp.definition
  ]
}


# Custom Config Definitions
module custom_guest_configs {
  source                = "..//modules/definition"
  for_each              = fileset("${path.module}/../policies/Guest Configuration", "CGC_*.json")
  policy_name           = replace(each.key, ".json", "")
  display_name          = each.key
  policy_category       = "Guest Configuration"
  management_group_name = data.azurerm_management_group.org.name

  depends_on = [
    null_resource.guest_config_packages_script
  ]
}

module custom_guest_configs_initiative {
  source                  = "..//modules/initiative"
  initiative_name         = "custom_guest_configs_initiative"
  initiative_display_name = "[CGC]: Deploys Custom Guest Config Packages"
  initiative_description  = "Deploys and configures Custom Guest Configuration packages for Windows and Linux VM and Hybrid Compute"
  initiative_category     = "Guest Configuration"
  management_group_name   = data.azurerm_management_group.org.name

  member_definitions = [ 
    for cgc in module.custom_guest_configs :
    cgc.definition
  ]
}
