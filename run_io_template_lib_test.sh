#!/bin/bash

set -e

# ------------------------------------------------------------------------
#
# run_io_template_lib_test.sh: Process IO-TEMPLATE-LIB tasks.
#
# ------------------------------------------------------------------------

# ------------------------------------------------------------------------
# Set environment name
# ------------------------------------------------------------------------
export MODULE=iotemplateapp

# ------------------------------------------------------------------------
# Set environment for Dynaconf
# ------------------------------------------------------------------------
export ENV_FOR_DYNACONF=test

# ------------------------------------------------------------------------
# Initialize task variables
# ------------------------------------------------------------------------
export IO_AERO_TASK=${1:-} # Default to empty if no argument is passed
export IO_AERO_TASK_DEFAULT="version"

# ------------------------------------------------------------------------
# Set Python path
# ------------------------------------------------------------------------
export PYTHONPATH=.

# ------------------------------------------------------------------------
# Handle task input
# ------------------------------------------------------------------------
if [ -z "$1" ]; then
    echo "==================================================================="
    echo "version - Show the IO-TEMPLATE-APP version"
    echo "-------------------------------------------------------------------"
    read -p "Enter the desired task [default: ${IO_AERO_TASK_DEFAULT}]: " IO_AERO_TASK
    export IO_AERO_TASK=${IO_AERO_TASK}

    if [ -z "${IO_AERO_TASK}" ]; then
        export IO_AERO_TASK=${IO_AERO_TASK_DEFAULT}
    fi
else
    export IO_AERO_TASK=$1
fi

# ------------------------------------------------------------------------
# Path to the log file
# ------------------------------------------------------------------------
log_file="run_io_template_lib_test_${IO_AERO_TASK}.log"

# ------------------------------------------------------------------------
# Function for logging messages
# ------------------------------------------------------------------------
log_message() {
    local message="$1"
    echo "$(date +"%d.%m.%Y %H:%M:%S"): $message" >> "$log_file"
}

# ------------------------------------------------------------------------
# Clean up old log files
# ------------------------------------------------------------------------
[ -f logging_io_aero.log ] && rm -f logging_io_aero.log
[ -f "${log_file}" ] && rm -f "${log_file}"

# ------------------------------------------------------------------------
# Redirect standard output and error to log file
# ------------------------------------------------------------------------
exec > >(while read -r line; do log_message "$line"; done) 2> >(while read -r line; do log_message "$line"; done)

echo "==================================================================="
echo "Start $0"
echo "-------------------------------------------------------------------"
echo "IO_TEMPLATE_APP - Template for Application Repositories."
echo "-------------------------------------------------------------------"
echo "ENV_FOR_DYNACONF         : ${ENV_FOR_DYNACONF}"
echo "PYTHONPATH               : ${PYTHONPATH}"
echo "-------------------------------------------------------------------"
if [ -n "$CONDA_PREFIX" ]; then
    source "$(conda info --base)/etc/profile.d/conda.sh"
    conda activate ${MODULE}
    conda_env=$(basename "$CONDA_PREFIX")
    echo "Running in conda environment: $conda_env"
else
    echo "FATAL ERROR: Not running in a conda environment"
fi
echo "-------------------------------------------------------------------"
echo "TASK                     : ${IO_AERO_TASK}"
echo "-------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "==================================================================="

# -----------------------------------------------------------------------
# Task handling
# -----------------------------------------------------------------------
# version: Show the IO-TEMPLATE-APP version
# -----------------------------------------------------------------------
if [[ "${IO_AERO_TASK}" =~ ^(version)$ ]]; then
    if ! python scripts/launcher.py -t "${IO_AERO_TASK}"; then
        exit 255
    fi

# ------------------------------------------------------------------------
# Program abort due to wrong input.
# ------------------------------------------------------------------------
else
    echo "Unknown task '${IO_AERO_TASK}'" >&2
    exit 255
fi

echo "-------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "-------------------------------------------------------------------"
echo "End   $0"
echo "==================================================================="

# Close the log file
log_message "Script finished."
