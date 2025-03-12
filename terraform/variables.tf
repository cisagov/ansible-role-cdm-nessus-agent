# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "nessus_agent_bucket" {
  description = "The name of the S3 bucket where the Nessus Agent installer lives."
  nullable    = false
  type        = string
}

variable "terraform_state_bucket" {
  description = "The name of the S3 bucket where Terraform state is stored."
  nullable    = false
  type        = string
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  nullable    = false
  type        = string
}

variable "nessus_agent_objects" {
  default = [
    "NessusAgent-*",
    "RPM-GPG-KEY-Tenable-*",
  ]
  description = "The Nessus Agent system package objects inside the bucket."
  nullable    = false
  type        = list(string)
}

variable "tags" {
  default = {
    Team        = "VM Fusion - Development"
    Application = "ansible-role-cdm-nessus-agent testing"
  }
  description = "Tags to apply to all AWS resources created"
  nullable    = false
  type        = map(string)
}
