# Copyright (c) 2022-2024 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

"""Module iotemplatelib: Entry Point Functionality.

This is the entry point to the library IO-TEMPLATE-LIB.
"""
import locale
import logging
import sys

import tomli
from iocommon import file, io_glob, io_logger

from iotemplatelib import glob_local

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------
_LOCALE = "en_US.UTF-8"

logger = logging.getLogger(__name__)


# -----------------------------------------------------------------------------
# Print the version number from pyproject.toml.
# -----------------------------------------------------------------------------
def _print_project_version() -> None:
    """Print the version number from pyproject.toml."""
    # Open the pyproject.toml file in read mode
    with open("pyproject.toml", "rb") as toml_file:  # noqa: PTH123
        # Use toml.load() to parse the file and store the data in a dictionary
        pyproject = tomli.load(toml_file)

    # Extract the version information
    # This method safely handles cases where the key might not exist
    version = pyproject.get("project", {}).get("version")

    # Check if the version is found and print it
    if version:
        logger.info("IO-TEMPLATE-LIB version: %s", version)
    else:
        # If the version isn't found, print an appropriate message
        logger.fatal("IO-TEMPLATE-LIB version not found in pyproject.toml")


# -----------------------------------------------------------------------------
# Initialising the logging functionality.
# -----------------------------------------------------------------------------
def main(argv: list[str]) -> None:
    """Entry point.

    The processes to be carried out are selected via command line arguments.

    Args:
    ----
        argv (list[str]): Command line arguments.

    """
    # Initialise the logging functionality.
    io_logger.initialise_logger()

    logger.debug(io_glob.LOGGER_START)
    logger.debug("param argv=%s", argv)

    logger.info("Start launcher.py")

    try:
        locale.setlocale(locale.LC_ALL, glob_local.LOCALE)
    except locale.Error:
        locale.setlocale(locale.LC_ALL, "en_US.UTF-8")

    logger.info("locale=%s", locale.getlocale())

    file.print_version_pkg_struct("iotemplatelib")
    file.print_pkg_structs(["iocommon"])
    _print_project_version()

    logger.info("End   launcher.py")
    logger.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Program start.
# -----------------------------------------------------------------------------
if __name__ == "__main__":
    # not testable
    main(sys.argv)
