# Azure Policy Deployments

This examples folder demonstrates an effective deployment of Azure Policy Definitions and Assignments. The order of execution is generally from `definitions.tf` -> `initiatives.tf` -> `assignments_<scope>.tf` -> `exemptions.tf`

> 💡 **Note:** `built-in.tf` demonstrates how to assign Built-In definitions.
