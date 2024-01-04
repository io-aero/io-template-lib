# Copyright (c) 2022-2024 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

"""Test the configuration main file."""
from iotemplatelib.io_settings import settings


def test_dynaconf_settings():
    """Test the dynaconf settings functionality."""
    assert settings.is_verbose is True
