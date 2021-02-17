"""Module containing the tests for the default scenario."""

# Standard Python Libraries
import os

# Third-Party Libraries
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_nessus_agent_installed(host):
    """Test that Nessus Agent was installed."""
    dir_full_path = "/opt/nessus_agent"
    directory = host.file(dir_full_path)
    assert directory.exists
    assert directory.is_directory
    # Make sure that the directory is not empty
    assert host.run_expect([0], f'[ -n "$(ls -A {dir_full_path})" ]')


def test_nessus_agent_enabled(host):
    """Test that Nessus Agent is enabled."""
    assert host.service("nessusagent").is_enabled
