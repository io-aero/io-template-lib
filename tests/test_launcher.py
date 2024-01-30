# Copyright (c) 2022-2024 IO-Aero. All rights reserved.
# Use of this source code is governed by the GNU LESSER GENERAL
# PUBLIC LICENSE, that can be found in the LICENSE.md file.

"""Launcher: coverage testing."""
import logging
import os
import platform

from iocommon import io_glob
from iocommon.io_config import settings

from iotemplatelib import glob_local

# -----------------------------------------------------------------------------
# Constants & Globals.
# -----------------------------------------------------------------------------

logger = logging.getLogger(__name__)


# -----------------------------------------------------------------------------
# Test case: version - Show the IO-TEMPLATE-LIB version.
# -----------------------------------------------------------------------------
# pylint: disable=R0801
def test_launcher_version():
    """Test case: launcher()."""
    # -------------------------------------------------------------------------
    logger.debug(io_glob.LOGGER_START)

    assert settings.check_value == "test"

    if platform.system() == "Darwin":
        exit_code = os.system("./run_io_template_lib_pytest.zsh version")
    elif platform.system() == "Linux":
        exit_code = os.system("./run_io_template_lib_pytest.sh version")
    elif platform.system() == "Windows":
        exit_code = os.system("run_io_template_lib_pytest.bat version")
    else:
        # FATAL.00.908 The operating system '{os}' is not supported
        assert False, glob_local.FATAL_00_908.replace("{os}", platform.system())

    assert exit_code == 0, f"Command failed with exit code {exit_code}"

    logger.debug(io_glob.LOGGER_END)
