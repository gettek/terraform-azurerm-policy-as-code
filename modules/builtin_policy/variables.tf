variable "display_name" {
  type        = string
  description = "displayName of the policy in Azure policy definition, not to be confsed with name (id)"
  default     = ""

  validation {
    condition     = length(var.display_name) <= 128
    error_message = "Definition display names have a maximum 128 character limit."
  }
}
