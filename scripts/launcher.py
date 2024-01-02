# Copyright (c) 2022-2023 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

"""Module iotemplatelib: Entry Point Functionality.

This is the entry point to the library IO-TEMPLATE-LIB.
"""
import locale
import logging
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

    logger = logging.getLogger(__name__)

    logger.debug(io_glob.LOGGER_START)
    logger.debug("param argv=%s", argv)
    locale.setlocale(locale.LC_ALL, _LOCALE)

    logger.info("Start launcher.py")

    file.print_version_pkg_struct("iotemplatelib")
    file.print_pkg_structs(["iocommon"])

    logger.info("End   launcher.py")
    logger.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Program start.
# -----------------------------------------------------------------------------
if __name__ == "__main__":
    # not testable
    main(sys.argv)
