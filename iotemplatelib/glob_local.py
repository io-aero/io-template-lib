# Copyright (c) 2022-2023 IO-Aero. All rights reserved.
# Use of this source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

"""Global constants and variables for IO-Aero systems.

This module defines a set of constants and variables that are globally
used throughout the IO-Aero software projects. These include configuration
parameters, error messages, and default settings that are essential for
the operation and error handling within various components of the system.

Attributes
----------
    ARG_TASK (str): A constant key used to reference the 'task' argument
        in function calls and command line arguments throughout the software.
    ARG_TASK_CHOICE (str): Initially set to an empty string, this variable
        is intended to hold the user's choice of task once determined at runtime.
    ARG_TASK_VERSION (str): A constant key used to reference the 'version'
        argument for tasks, indicating the version of the task being used.
    FATAL_00_908 (str): Error message template for unsupported operating systems.
        This message is formatted with the name of the OS when raised.
    IO_TEMPLATE_LIB_VERSION (str): The current version number of the IO-Aero
        template library, indicating the version of the global constants and variables.
    LOCALE (str): Default locale setting for the system to 'en_US.UTF-8',
        ensuring consistent language and regional format settings.

"""
# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------

ARG_TASK = "task"
ARG_TASK_CHOICE = ""
ARG_TASK_VERSION = "version"

# Fatal error messages.
FATAL_00_908 = "FATAL.00.908 The operating system '{os}' is not supported"

# Library version number.
IO_TEMPLATE_LIB_VERSION = "1.0.0"

LOCALE = "en_US.UTF-8"

# Warning messages.
