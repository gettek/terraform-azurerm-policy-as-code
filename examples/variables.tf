# ----------------------------------------------------------------------------------------------------------------------
# Module variables
# ----------------------------------------------------------------------------------------------------------------------

variable skip_remediation {
  type        = bool
  description = "Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify"
  default     = true
}

variable team_a_subscription_id {
  type        = string
  description = "Team A Subscription Id"
  default     = "26daef58-833e-4124-b0c8-afd7619ca427"
}
