# Copyright (c) 2022-2024 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.
"""Module iotemplatelib: Entry Point Functionality.

This is the entry point to the library IO-TEMPLATE-LIB.
"""

import locale
import logging
import sys
from pathlib import Path

import tomli
from dynaconf import Dynaconf  # type: ignore
from iocommon import io_glob, io_logger

from iotemplatelib import glob_local

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------

io_logger.initialise_logger()

_LOCALE = "en_US.UTF-8"


# -----------------------------------------------------------------------------

def _print_dynaconf_settings() -> None:
    """Print all settings managed by Dynaconf in a specific format.

    This function initializes a Dynaconf instance with specified settings files and prints each
    configuration parameter using a specific message format. The format is defined by the
    glob_local.INFO_00_007 string.

    """
    # Initialize Dynaconf instance with your config settings
    settings = Dynaconf(
        settings_files=["settings.toml", "settings.io_aero.toml"],  # Example config files
    )

    # Iterate through all settings and print them using the formatted message
    for section, item in settings.as_dict().items():
        for key, value in item.items():
            # INFO.00.007 Section: '{section}' - Parameter: '{name}'='{value}'
            message = (
                glob_local.INFO_00_007.replace("{section}", section)
                .replace("{name}", key)
                .replace("{value}", str(value))
            )
            # Print the formatted message as an info message
            logging.info(message)


# -----------------------------------------------------------------------------

def _print_project_version() -> None:
    """Print the version number from pyproject.toml.

    Open the pyproject.toml file, parse it using tomllib, extract the version information, and print
    it. If any errors occur while opening or parsing the file, print an appropriate error message
    and return.

    """
    try:
        # Open the pyproject.toml file in read mode.
        # The 'rb' argument is used to read the file in binary mode.
        with Path("pyproject.toml").open("rb") as toml_file:
            # Use tomllib.load() to parse the file and store the data in a dictionary.
            pyproject = tomli.load(toml_file)
    except FileNotFoundError:
        logging.exception("pyproject.toml file not found")
        return
    except tomli.TOMLDecodeError:
        logging.exception("Error decoding TOML file: %s")
        return

    # Extract the version information from the dictionary.
    # The method safely handles cases where the key might not exist.
    version = pyproject.get("project", {}).get("version")

    # Check if the version is found and print it.
    # If the version isn't found, print an appropriate message.
    if version:
        logging.info("IO-TEMPLATE-LIB version: %s", version)
    else:
        logging.fatal("IO-TEMPLATE-LIB version not found in pyproject.toml")


# -----------------------------------------------------------------------------

def main(argv: list[str]) -> None:
    """Entry point.

    The processes to be carried out are selected via command line arguments.

    Args:
    ----
        argv (list[str]): Command line arguments.

    This function is the entry point of the launcher script. It is called when the script
    is started from the command line. The function is responsible for parsing the command
    line arguments, setting the locale to 'en_US.UTF-8', and calling the appropriate
    functions based on the command line arguments.

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

if __name__ == "__main__":
    # not testable
    main(sys.argv)
