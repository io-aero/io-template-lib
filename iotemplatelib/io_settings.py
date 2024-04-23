# Copyright (c) 2022-2024 IO-Aero. All rights reserved.
# Use of this source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

"""Managing the application configuration parameters.

This module initializes and configures the settings for the IO-Aero application
using the Dynaconf library. It allows for a flexible, environment-specific
configuration that supports multiple file formats and environment variables.

Attributes
----------
    settings (Dynaconf): A configuration object that handles the application
        settings. It is set to read configuration from TOML files specific to
        the IO-Aero project and environment variables with a specific prefix.

    Usage
    This module should be imported to access the `settings` object which provides
    the configuration parameters across the application. For example:
        from config_module import settings
        print(settings.SOME_CONFIGURATION_KEY)

"""

from dynaconf import Dynaconf  # type: ignore

settings = Dynaconf(
    environments=True,  # Enable support for multi-environment settings
    envvar_prefix="IO_AERO_CONFIG",  # Prefix for environment variables to pull settings
    settings_files=[
        "settings.io_aero.toml",
        ".settings.io_aero.toml",
    ],  # Configuration files
)
