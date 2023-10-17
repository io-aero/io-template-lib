# Copyright (c) 2022-2023 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

import logging.config

from iotemplatelib import io_glob as io_glob

LOGGER_END: str
LOGGER_NAME: str
LOGGER_START: str
io_log: logging.Logger

def initialise_logger(log_level: int = ...) -> None: ...
def set_logging_level(level: int) -> int: ...
