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
from iocommon.io_config import settings

from iotemplatelib import glob_local

# -----------------------------------------------------------------------------
# Constants & Globals.
# -----------------------------------------------------------------------------

logger = logging.getLogger(__name__)


# -----------------------------------------------------------------------------
# Run shell commands safely.
# -----------------------------------------------------------------------------
def _run_command(command: str) -> None:
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
        pytest.fail(f"Command failed with exit code {e.returncode}")


# -----------------------------------------------------------------------------
# Setup and teardown fixture for all tests.
# -----------------------------------------------------------------------------
@pytest.fixture(scope="session", autouse=True)
def _setup_and_teardown() -> None:
    """Setup and teardown fixture for all tests."""  # noqa: D401
    logger.debug(io_glob.LOGGER_START)

    os.environ["ENV_FOR_DYNACONF"] = "test"

    yield  # This is where the testing happens

    logger.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Test case: version - Show the IO-TEMPLATE-LIB version.
# -----------------------------------------------------------------------------
def test_launcher_version() -> None:
    """Test case: launcher() version."""
    assert settings.check_value == "test", "Settings check_value is not 'test'"

    commands = {
        "Darwin": ["./run_io_template_lib_pytest.zsh", "version"],
        "Linux": ["./run_io_template_lib_pytest.sh", "version"],
        "Windows": ["cmd.exe", "/c", "run_io_template_lib_pytest.bat", "version"],
    }
    command = commands.get(platform.system())
    if not command:
        pytest.fail(glob_local.FATAL_00_908.replace("{os}", platform.system()))

    _run_command(command)
