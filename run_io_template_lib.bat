@echo off

rem ----------------------------------------------------------------------------
rem
rem run_io_template_lib.bat: Process IO-TEMPLATE-LIB tasks.
rem
rem ----------------------------------------------------------------------------

setlocal EnableDelayedExpansion

set ERRORLEVEL=

if ["!ENV_FOR_DYNACONF!"] EQU [""] (
    set ENV_FOR_DYNACONF=prod
)
set PYTHONPATH=.

echo.
echo Script %0 is now running

if exist logging_io_aero.log (
    del /f /q logging_io_aero.log
)

echo =======================================================================
echo Start %0
echo -----------------------------------------------------------------------
echo IO_TEMPLATE_LIB - Template Library.
echo -----------------------------------------------------------------------
echo ENVIRONMENT_TYPE : %ENV_FOR_DYNACONF%
echo PYTHONPATH       : %PYTHONPATH%
echo -----------------------------------------------------------------------
echo:| TIME
echo =======================================================================

pipenv run python scripts\launcher.py
if ERRORLEVEL 1 (
    echo Processing of the script: %0 - step: 'python scripts\launcher.py was aborted
)

echo.
echo -----------------------------------------------------------------------
echo:| TIME
echo -----------------------------------------------------------------------
echo End   %0
echo =======================================================================
