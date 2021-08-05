# ansible-role-cdm-nessus-agent #

[![GitHub Build Status](https://github.com/cisagov/ansible-role-cdm-nessus-agent/workflows/build/badge.svg)](https://github.com/cisagov/ansible-role-cdm-nessus-agent/actions)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/cisagov/ansible-role-cdm-nessus-agent.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/cisagov/ansible-role-cdm-nessus-agent/alerts/)
[![Language grade: Python](https://img.shields.io/lgtm/grade/python/g/cisagov/ansible-role-cdm-nessus-agent.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/cisagov/ansible-role-cdm-nessus-agent/context:python)

This is an Ansible role for installing [Nessus
Agent](https://www.tenable.com/products/nessus/nessus-agents),
specifically for the CISA Continuous Diagnostics and Mitigation (CDM)
environment.

Note that the command to link the Nessus Agent to the Tenable/Nessus
server (`nessuscli agent link`) _is not_ run by this Ansible role.  It
must be run at instance startup via
[`cloud-init`](https://cloud-init.io/) or a separate Ansible playbook.
The reason for this is that this Ansible role is used to build AWS
AMIs, and the linking command generates the Tenable tag _even if run
with the `--offline-install` option_.  This causes all instances
generates from that AMI to have the same Tenable tag, and the Tenable
server cannot handle such duplicate agents.

I would prefer to perform all configuration at AMI build time; but,
unless Nessus modifies their code to, for example, allow one to
specify the linking parameters ahead of time we are stuck with this
substandard solution.

## Pre-requisites ##

In order to execute the Molecule tests for this Ansible role in GitHub
Actions, a build user must exist in AWS. The accompanying Terraform
code will create the user with the appropriate name and
permissions. This only needs to be run once per project, per AWS
account. This user can also be used to run the Molecule tests on your
local machine.

Before the build user can be created, the following profile must exist in
your AWS credentials file:

- `cool-terraform-backend`

The easiest way to set up that profile is to use our
[`aws-profile-sync`](https://github.com/cisagov/aws-profile-sync)
utility. Follow the usage instructions in that repository before
continuing with the next steps. Note that you will need to know where
your team stores their remote profile data in order to use
[`aws-profile-sync`](https://github.com/cisagov/aws-profile-sync).

To create the build user, follow these instructions:

```console
cd terraform
terraform init --upgrade=true
terraform apply
```

Once the user is created you will need to update the [repository's
secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets)
with the new encrypted environment variables. This should be done
using the
[`terraform-to-secrets`](https://github.com/cisagov/development-guide/tree/develop/project_setup#terraform-iam-credentials-to-github-secrets-)
tool available in the [development
guide](https://github.com/cisagov/development-guide). Instructions for
how to use this tool can be found in the ["Terraform IAM Credentials
to GitHub Secrets"
section](https://github.com/cisagov/development-guide/tree/develop/project_setup#terraform-iam-credentials-to-github-secrets-).
of the Project Setup README.

If you have appropriate permissions for the repository you can view
existing secrets on the [appropriate
page](https://github.com/cisagov/ansible-role-cdm-nessus-agent/settings/secrets)
in the repository's settings.

## Requirements ##

None.

## Role Variables ##

* `install_directory` - the directory where Nessus Agent is installed.
  Defaults to "/opt/nessus_agent".
* `third_party_bucket_name` - the name of the AWS S3 bucket where
  third-party software is located.  Defaults to
  "cisa-cool-third-party-production".

## Dependencies ##

* [cisagov/ansible-role-dhs-certificates](https://github.com/cisagov/ansible-role-dhs-certificates)
* [cisagov/ansible-role-cdm-certificates](https://github.com/cisagov/ansible-role-cdm-certificates)

## Example Playbook ##

Here's how to use it in a playbook:

```yaml
- hosts: all
  become: yes
  become_method: sudo
  roles:
    - cdm_nessus_agent
```

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.

## Author Information ##

Shane Frasier - <jeremy.frasier@trio.dhs.gov>
