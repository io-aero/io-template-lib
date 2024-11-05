#!/bin/bash

set -e

# ------------------------------------------------------------------------------
#
# run_install_mamba.sh: Install Mamba on Ubuntu.
#
# ------------------------------------------------------------------------------

# Set the Python version
PYTHON_VERSION="3.12"
INSTALL_PATH="$HOME/miniforge3"

echo "=========================================================================="
echo "Downloading Mamba installer."
echo "--------------------------------------------------------------------------"
wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"

echo "=========================================================================="
echo "Installing Mamba in batch mode."
echo "--------------------------------------------------------------------------"
chmod +x Miniforge3.sh
./Miniforge3.sh -b -p "$INSTALL_PATH"

echo "=========================================================================="
echo "Initializing Mamba for bash."
echo "--------------------------------------------------------------------------"
source "$INSTALL_PATH/bin/activate"  # Initialize the conda environment
conda init bash  # Initialize bash support for conda

echo "=========================================================================="
echo "Updating PATH for Mamba usage."
echo "--------------------------------------------------------------------------"
export PATH="$INSTALL_PATH/bin:$PATH"

echo "=========================================================================="
echo "Verifying Mamba installation."
echo "--------------------------------------------------------------------------"
mamba info

echo "=========================================================================="
echo "Installing Python version ${PYTHON_VERSION}."
echo "--------------------------------------------------------------------------"
mamba install -y python=${PYTHON_VERSION}
python3 --version

echo "--------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "--------------------------------------------------------------------------"
echo "End   $0"
echo "=========================================================================="
