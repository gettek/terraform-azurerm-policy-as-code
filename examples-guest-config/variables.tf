# ----------------------------------------------------------------------------------------------------------------------
# Module variables
# ----------------------------------------------------------------------------------------------------------------------

variable "skip_remediation" {
  type        = bool
  description = "Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify"
  default     = false
}

variable "build_packages" {
  type        = bool
  description = "Create and publish custom guest config polices with build_guest_config_packages.ps1"
  default     = true
}
