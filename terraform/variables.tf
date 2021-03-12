# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
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
    "RPM-GPG-KEY-Tenable-2048",
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
    "RPM-GPG-KEY-Tenable-2048",
  ]
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"

  default = {
    Team        = "VM Fusion - Development"
    Application = "ansible-role-cdm-nessus-agent testing"
  }
}
