#!/bin/bash

set -e

# ---------------------------------------------------------------------------
#
# run_io_template_lib.sh: Process IO-TEMPLATE-LIB tasks.
#
# ---------------------------------------------------------------------------

# Accept environment as an argument
ENV_FOR_DYNACONF=$1
export ENV_FOR_DYNACONF
export IO_AERO_TASK_DEFAULT=version
export PYTHONPATH=.

# Prompt for task if not provided as a second argument
if [ -z "$2" ]; then
    echo "==================================================================="
    echo "version - Show the IO-TEMPLATE-LIB version"
    echo "-------------------------------------------------------------------"
    read -p "Enter the desired task [default: ${IO_AERO_TASK_DEFAULT}] " IO_AERO_TASK
    IO_AERO_TASK=${IO_AERO_TASK:-$IO_AERO_TASK_DEFAULT}
else
    IO_AERO_TASK=$2
fi

# Path to the log file
log_file="run_io_template_lib_${ENV_FOR_DYNACONF}_${IO_AERO_TASK}.log"

# Function for logging messages
log_message() {
  local message="$1"
  local timestamp
  timestamp=$(date +"%d.%m.%Y %H:%M:%S")
  echo "$timestamp: $message" >> "$log_file"
}

# Clear previous log files if they exist
[ -f logging_io_aero.log ] && rm -f logging_io_aero.log
[ -f "$log_file" ] && rm -f "$log_file"

# Redirect stdout and stderr to log file
exec > >(while read -r line; do log_message "$line"; done) \
     2> >(while read -r line; do log_message "$line"; done)

# Display header information
echo "======================================================================="
echo "Start $0"
echo "-----------------------------------------------------------------------"
echo "IO_TEMPLATE_LIB - Template for Library Repositories."
echo "-----------------------------------------------------------------------"
echo "ENV_FOR_DYNACONF         : ${ENV_FOR_DYNACONF}"
echo "PYTHONPATH               : ${PYTHONPATH}"
echo "-----------------------------------------------------------------------"
echo "TASK                     : ${IO_AERO_TASK}"
echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "======================================================================="

# Execute task
if [[ "${IO_AERO_TASK}" =~ ^(version)$ ]]; then
    if ! python3 scripts/launcher.py -t "${IO_AERO_TASK}"; then
        log_message "Error executing launcher.py with task ${IO_AERO_TASK}" "ERROR"
        exit 255
    fi
else
    echo "Processing aborted: unknown task='${IO_AERO_TASK}'"
    log_message "Processing aborted: unknown task='${IO_AERO_TASK}'" "ERROR"
    exit 255
fi

# Completion message
echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "-----------------------------------------------------------------------"
echo "End   $0"
echo "======================================================================="
log_message "Script finished."
