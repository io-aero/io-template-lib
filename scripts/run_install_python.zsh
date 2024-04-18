#!/bin/zsh

set -e

# ------------------------------------------------------------------------------
#
# run_install_python.zsh: Install Python via Homebrew on macOS.
#
# ------------------------------------------------------------------------------

# Set the Python version
PYTHON_VERSION="3.12"

echo "=========================================================================="
echo "Updating Homebrew."
echo "--------------------------------------------------------------------------"
brew update

echo "=========================================================================="
echo "Install Python."
echo "--------------------------------------------------------------------------"
brew install -y python@${PYTHON_VERSION}
python3 --version

echo "=========================================================================="
echo "Python 3 and pip3 are installed with Homebrew Python."
echo "--------------------------------------------------------------------------"
pip3 --version

echo "--------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "--------------------------------------------------------------------------"
echo "End   $0"
echo "=========================================================================="
