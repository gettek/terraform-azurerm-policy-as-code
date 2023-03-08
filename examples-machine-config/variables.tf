# ----------------------------------------------------------------------------------------------------------------------
# Module variables
# ----------------------------------------------------------------------------------------------------------------------

variable "skip_remediation" {
  type        = bool
  description = "Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify"
  default     = true
}

variable "skip_role_assignment" {
  type        = bool
  description = "Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify"
  default     = false
}

variable "re_evaluate_compliance" {
  type        = bool
  description = "Should the module re-evaluate compliant resources for policies that DeployIfNotExists and Modify"
  default     = false
}

variable "build_packages" {
  type        = bool
  description = "Create and publish custom machine config polices with build_machine_config_packages.ps1"
  default     = true
}

locals {
  resource_discovery_mode = var.re_evaluate_compliance == true ? "ReEvaluateCompliance" : "ExistingNonCompliant"
}
