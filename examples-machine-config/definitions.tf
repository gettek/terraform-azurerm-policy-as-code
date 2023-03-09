##################
# Guest Configuration: Custom Machine Configuration Definitions
##################

module "custom_guest_configs" {
  source              = "..//modules/definition"
  for_each            = toset([for p in fileset(path.module, "../policies/Guest Configuration/*.json") : trimsuffix(basename(p), ".json")])
  policy_name         = each.key
  policy_category     = "Guest Configuration"
  management_group_id = data.azurerm_management_group.org.id

  depends_on = [
    null_resource.build_machine_config_packages
  ]
}

module "custom_guest_configs_initiative" {
  source                  = "..//modules/initiative"
  initiative_name         = "custom_guest_configs_initiative"
  initiative_display_name = "[CGC]: Custom Guest Configurations Initiative"
  initiative_description  = "Collection of policies that deploy custom machine configurations"
  initiative_category     = "Guest Configuration"
  management_group_id     = data.azurerm_management_group.org.id
  member_definitions      = [for cgc in module.custom_guest_configs : cgc.definition]
}
