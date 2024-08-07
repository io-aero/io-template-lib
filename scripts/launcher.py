# Copyright (c) 2022-2024 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.
"""Module iotemplatelib: Entry Point Functionality.

This is the entry point to the library IO-TEMPLATE-LIB.
"""
import locale
import logging
import sys
import tomllib
from pathlib import Path

from iocommon import io_glob

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# Print the version number from pyproject.toml.
# -----------------------------------------------------------------------------
def _print_project_version() -> None:
    """Print the version number from pyproject.toml."""
    try:
        # Open the pyproject.toml file in read mode
        with Path("pyproject.toml").open("rb") as toml_file:
            # Use tomllib.load() to parse the file and store the data in a dictionary
            pyproject = tomllib.load(toml_file)
    except FileNotFoundError:
        logging.exception("pyproject.toml file not found")
        return
    except tomllib.TOMLDecodeError:
        logging.exception("Error decoding TOML file: %s")
        return

    # Extract the version information
    # This method safely handles cases where the key might not exist
    version = pyproject.get("project", {}).get("version")

    # Check if the version is found and print it
    if version:
        logging.info("IO-TEMPLATE-LIB version: %s", version)
    else:
        # If the version isn't found, print an appropriate message
        logging.fatal("IO-TEMPLATE-LIB version not found in pyproject.toml")


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
    logging.debug(io_glob.LOGGER_START)
    logging.debug("param argv=%s", argv)

    logging.info("Start launcher.py")

    locale.setlocale(locale.LC_ALL, "en_US.UTF-8")

    logging.info("locale=%s", locale.getlocale())

    _print_project_version()

    logging.info("End   launcher.py")
    logging.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Program start.
# -----------------------------------------------------------------------------
if __name__ == "__main__":
    # not testable
    main(sys.argv)
