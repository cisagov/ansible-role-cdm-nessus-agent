# Create the test user
module "user" {
  source = "github.com/cisagov/molecule-iam-user-tf-module"

  providers = {
    aws                         = aws.users
    aws.images-provisionaccount = aws.images_provisionaccount
    aws.images-ssm              = aws.images_ssm
  }

  entity = "ansible-role-cdm-nessus-agent"
  # If necessary, provide a list of SSM Parameter Store parameters that the test user needs to
  # be able to read.  In particular, roles that require access to
  # resources inside the third-party bucket will likely need to access the
  # name of that bucket via such a parameter.
  # ssm_parameters = ["/third_party_bucket_name"]
}

# Attach third-party S3 bucket read-only policy from
# cisagov/ansible-role-cdm-certificates to the test user role
resource "aws_iam_role_policy_attachment" "thirdpartybucketread_certificates" {
  provider = aws.images_provisionaccount

  policy_arn = data.terraform_remote_state.ansible_role_cdm_certificates.outputs.bucket_access_policy.arn
  role       = module.user.role.name
  # If necessary, provide a list of SSM Parameter Store parameters that the test user needs to
  # be able to read.  In particular, roles that require access to
  # resources inside the third-party bucket will likely need to access the
  # name of that bucket via such a parameter.
  # ssm_parameters = ["/third_party_bucket_name"]
}
