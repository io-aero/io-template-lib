# Copyright (c) 2022-2024 IO-Aero. All rights reserved.
# Use of this source code is governed by the GNU LESSER GENERAL
# PUBLIC LICENSE, that can be found in the LICENSE.md file.
"""Launcher: coverage testing."""
import logging
import os
import platform
import subprocess

import pytest
from iocommon import io_glob
from iocommon.io_settings import settings

# -----------------------------------------------------------------------------
# Constants & Globals.
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# Run shell commands safely.
# -----------------------------------------------------------------------------
def _run_command(command: list[str]) -> None:
    """Run shell commands safely."""
    try:
        subprocess.run(
            command,
            check=True,
            shell=False,
            text=True,
            capture_output=True,
        )
    except subprocess.CalledProcessError as e:
        print(  # noqa: T201
            f"test_launcher - stdout: '{e.stdout}'",
        )  # Print stdout for additional context
        print(  # noqa: T201
            f"test_launcher - stderr: '{e.stderr}'",
        )  # This will print the error output
        pytest.fail(
            f"test_launcher - command failed with exit code: {e.returncode}",
        )


# -----------------------------------------------------------------------------
# Setup and teardown fixture for all tests.
# -----------------------------------------------------------------------------
@pytest.fixture(scope="session", autouse=True)
def _setup_and_teardown() -> None:  # type: ignore
    """Setup and teardown fixture for all tests."""  # noqa: D401
    logging.debug(io_glob.LOGGER_START)

    os.environ["ENV_FOR_DYNACONF"] = "test"

    yield  # This is where the testing happens

    logging.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Test case: version - Show the IO-TEMPLATE-LIB version.
# -----------------------------------------------------------------------------
def test_launcher_version() -> None:
    """Test case: launcher() version."""
    assert settings.check_value == "test", "Settings check_value is not 'test'"

    commands = {
        "Linux": ["./run_io_template_lib_test.sh", "version"],
    }
    command = commands.get(platform.system())
    if not command:
        pytest.fail(io_glob.FATAL_00_908.replace("{os}", platform.system()))

    _run_command(command)
