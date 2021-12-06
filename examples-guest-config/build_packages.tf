resource "azurerm_resource_group" "guest_config_rg" {
  name     = "dsc"
  location = "uksouth"
  tags     = {}
}

resource azurerm_storage_account guest_config_store {
  name                = "guestconfig${substr(md5(data.azurerm_client_config.current.subscription_id), 0, 5)}"
  resource_group_name = azurerm_resource_group.guest_config_rg.name
  location            = azurerm_resource_group.guest_config_rg.location

  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  access_tier               = "Hot"
  allow_blob_public_access  = true
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  network_rules {
    default_action = "Allow"
  }
}

resource azurerm_storage_container guest_config_container {
  name                  = "configs"
  storage_account_name  = azurerm_storage_account.guest_config_store.name
  container_access_type = "blob"
}

locals {
  script_params = {
    rg        = azurerm_resource_group.guest_config_rg.name
    sa        = azurerm_storage_account.guest_config_store.name
    container = azurerm_storage_container.guest_config_container.name
  }
}

# execute script to build and publish custom guest config packages located in scripts/dsc_examples
# requires PWSH >= 7
resource "null_resource" "guest_config_packages_script" {
  count = var.build_packages ? 1 : 0
  provisioner "local-exec" {
    command     = "pwsh -file build_guest_config_packages.ps1 -checkDependancies -connectAzAccount -housekeeping -storageResourceGroupName ${local.script_params.rg} -storageAccountName ${local.script_params.sa} -containerName ${local.script_params.container}"
    interpreter = ["PowerShell", "-Command"]
    working_dir = "${path.module}/../scripts"
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [
    azurerm_resource_group.guest_config_rg,
    azurerm_storage_account.guest_config_store,
    azurerm_storage_container.guest_config_container
  ]
}
