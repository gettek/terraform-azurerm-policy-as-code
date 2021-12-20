# execute script to build and publish custom guest config packages located in scripts/dsc_examples
# requires PWSH >= 7
resource "null_resource" "guest_config_packages_script" {
  count = var.build_packages ? 1 : 0
  provisioner "local-exec" {
    command     = "build_guest_config_packages.ps1"
    interpreter = ["pwsh", "-file"]
    working_dir = "${path.module}/../scripts"

    environment = {
      #connectAzAccount = "true"
      housekeeping = "true"
      checkDependancies = "true"
      createGuestConfigPackage = "true"
      createGuestConfigPolicy = "true"
      storageResourceGroupName = "dsc"
      storageAccountName = data.azurerm_storage_container.guest_config_container.storage_account_name
      containerName = data.azurerm_storage_container.guest_config_container.name
      publishGuestConfigPolicyMG = data.azurerm_management_group.org.name
    }
  }

  triggers = {
    always_run = timestamp()
  }
}
