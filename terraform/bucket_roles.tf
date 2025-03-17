# Create the role that allows read-only access to the particular S3
# objects that are required by this Ansible role
module "bucket_access" {
  source = "github.com/cisagov/s3-read-role-tf-module"
  providers = {
    aws = aws.images_provisionthirdpartybucketreadroles
  }

  account_ids = [data.aws_caller_identity.current.account_id]
  entity_name = module.user.user.name
  role_name   = "ThirdPartyBucketRead-${module.user.user.name}"
  s3_bucket   = var.nessus_agent_bucket
  s3_objects  = var.nessus_agent_objects
}

# Attach third-party S3 bucket read-only policy to the test user role
resource "aws_iam_role_policy_attachment" "thirdpartybucketread" {
  provider = aws.images_provisionaccount

  policy_arn = module.bucket_access.policy.arn
  role       = module.user.role.name
}
