# ----------------------------------------------------------------------------------------------------------------------
# Module variables
# ----------------------------------------------------------------------------------------------------------------------

variable "skip_remediation" {
  type        = bool
  description = "Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify"
  default     = false
}
