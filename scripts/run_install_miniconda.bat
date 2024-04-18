@echo off
SETLOCAL

echo ==========================================================================
echo Installing Miniconda
echo --------------------------------------------------------------------------

set PYTHON_VERSION=3.12

echo ==========================================================================
echo Downloading Miniconda installer...
echo --------------------------------------------------------------------------
curl -L "https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe" -o "%UserProfile%\miniconda-installer.exe"

echo ==========================================================================
echo Installing Miniconda...
echo --------------------------------------------------------------------------
start /wait "" "%UserProfile%\miniconda-installer.exe" /InstallationType=JustMe /RegisterPython=0 /S /D="%UserProfile%\Miniconda3"

echo ==========================================================================
echo Updating PATH for Miniconda...
echo --------------------------------------------------------------------------
SET "PATH=%UserProfile%\Miniconda3;%UserProfile%\Miniconda3\Scripts;%UserProfile%\Miniconda3\Library\bin;%PATH%"

echo ==========================================================================
echo Initializing Miniconda...
echo --------------------------------------------------------------------------
call conda init

echo ==========================================================================
echo Verifying Miniconda installation...
echo --------------------------------------------------------------------------
call conda info

echo ==========================================================================
echo Install Python.
echo --------------------------------------------------------------------------
call conda install -y python=%PYTHON_VERSION%
call python --version

echo -------------------------------------------------------------------------
echo DATE TIME: %DATE% %TIME%
echo -------------------------------------------------------------------------
echo End
echo ==========================================================================


