# Copyright (c) 2022-2023 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.
"""Module iotemplatelib: Entry Point Functionality.

This is the entry point to the library IO-TEMPLATE-LIB.
"""
import importlib
import locale
import sys

from iocommon import file
from iocommon import io_glob
from iocommon import io_logger

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------
_LOCALE = "en_US.UTF-8"


# -----------------------------------------------------------------------------
# Initialising the logging functionality.
# -----------------------------------------------------------------------------
def main(argv: list[str]) -> None:
    """Entry point.

    The processes to be carried out are selected via command line arguments.

    Args:
        argv (list[str]): Command line arguments.
    """
    # Initialise the logging functionality.
    io_logger.initialise_logger()

    io_glob.logger.debug(io_glob.LOGGER_START)
    io_glob.logger.debug("param argv=%s", argv)
    locale.setlocale(locale.LC_ALL, _LOCALE)

    io_glob.logger.info("Start launcher.py")

    try:
        print("Version iotemplatelib: {importlib.metadata.version('iotemplatelib')}")
        file.print_package_content("iotemplatelib")
    except importlib.metadata.PackageNotFoundError:
        print("Version iotemplatelib: package not found")
    file.print_package_content("iocommon")

    io_glob.logger.info("End   launcher.py")
    io_glob.logger.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Program start.
# -----------------------------------------------------------------------------
if __name__ == "__main__":
    # not testable
    main(sys.argv)
