#!/bin/zsh

set -e

# ------------------------------------------------------------------------------
#
# run_prep_bash_scripts.sh: Configure EOL and execution rights.
#
# ------------------------------------------------------------------------------

echo "=========================================================================="
echo "Start $0"
echo "--------------------------------------------------------------------------"
echo "Configure EOL and execution rights - macOS."
echo "--------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "=========================================================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew not installed. Installing now."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dos2unix if not already installed
if ! command -v dos2unix &> /dev/null
then
    echo "Installing dos2unix."
    brew install dos2unix
fi

chmod +x ./*.sh
chmod +x ./*/*.sh

dos2unix ./*.sh
dos2unix ./*/*.sh

echo "--------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "--------------------------------------------------------------------------"
echo "End   $0"
echo "=========================================================================="
