# execute script to build and publish custom guest config packages located in scripts/dsc_examples
# to build/update your configs first target this resource with parallelism set to 1 before running a complete apply:
# tf apply -target null_resource.build_machine_config_packages -parallelism=1 && tf apply
# requires PWSH >= 7

resource "null_resource" "build_machine_config_packages" {
  for_each = { for dsc in fileset(path.module, "../scripts/dsc_examples/*.ps1") : basename(dsc) => filemd5(dsc) }
  provisioner "local-exec" {
    command     = "build_machine_config_packages.ps1"
    interpreter = ["pwsh", "-file"]
    working_dir = "${path.module}/../scripts"

    environment = {
      configFile               = each.key
      connectAzAccount         = "true"
      checkDependancies        = "true"
      createGuestConfigPackage = "true"
      createGuestConfigPolicy  = "true"
      storageResourceGroupName = "cgc-cd"
      storageAccountName       = data.azurerm_storage_container.guest_config_container.storage_account_name
      containerName            = data.azurerm_storage_container.guest_config_container.name

      # the script can also publish definitions to managent groups
      # we will skip this step so that definition lifecycles are managed by terraform:
      #publishGuestConfigPolicyMG = data.azurerm_management_group.org.name
    }
  }

  triggers = {
    # changes to either filename or filecontents will trigger a rebuild
    "${each.key}" = each.value
  }
}
