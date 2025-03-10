# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

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

variable "production_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where the production Nessus Agent system packages live."
  default     = "cisa-cool-third-party-production"
}

variable "production_objects" {
  type        = list(string)
  description = "The Nessus Agent system package objects inside the production bucket."
  default = [
    "NessusAgent-*",
    "RPM-GPG-KEY-Tenable-*",
  ]
}

variable "staging_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where the staging Nessus Agent system packages live."
  default     = "cisa-cool-third-party-staging"
}

variable "staging_objects" {
  type        = list(string)
  description = "The Nessus Agent system packages inside the staging bucket."
  default = [
    "NessusAgent-*",
    "RPM-GPG-KEY-Tenable-*",
  ]
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
