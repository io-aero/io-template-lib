# Copyright (c) 2022-2024 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.
"""Managing the application configuration parameters."""
from dynaconf import Dynaconf  # type: ignore

settings = Dynaconf(
    environments=True,
    envvar_prefix="IO_AERO_CONFIG",
    settings_files=["settings.io_aero.toml", ".settings.io_aero.toml"],
)
