"""Module containing the tests for the default scenario."""

# Standard Python Libraries
import os

# Third-Party Libraries
import pytest
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


def test_nessus_agent_enabled_and_started(host):
    """Test that Nessus Agent is enabled and started."""
    svc = host.service("nessusagent")
    assert svc.is_enabled and svc.is_running


@pytest.mark.parametrize(
    "key, value",
    [
        ("update_hostname", "yes"),
    ],
)
def test_nessus_config(host, key, value):
    """Test that Nessus Agent non-secure configuration options are as expected."""
    assert value in host.check_output(
        f"/opt/nessus_agent/sbin/nessuscli fix --get {key}"
    )
