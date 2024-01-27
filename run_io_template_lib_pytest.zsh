#!/bin/zsh

set -e

# ------------------------------------------------------------------------------
#
# run_io_template_lib_pytest.zsh: Process IO-TEMPLATE-LIB tasks.
#
# ------------------------------------------------------------------------------

if [[ -z "${ENV_FOR_DYNACONF}" ]]; then
    export ENV_FOR_DYNACONF=test
fi

export IO_AERO_TASK=
export IO_AERO_TASK_DEFAULT=version

export PYTHONPATH=.

if [[ -z "$1" ]]; then
    echo "==================================================================="
    echo "version - Show the IO-TEMPLATE-LIB version"
    echo "-------------------------------------------------------------------"
    vared -p "Enter the desired task [default: ${IO_AERO_TASK_DEFAULT}] " -c IO_AERO_TASK
    export IO_AERO_TASK=${IO_AERO_TASK:-${IO_AERO_TASK_DEFAULT}}
else
    export IO_AERO_TASK=$1
fi

# Path to the log file
log_file="run_io_template_lib_pytest_${IO_AERO_TASK}.log"

# Function for logging messages
log_message() {
  local message="$1"
  # Format current date and time with timestamp
  timestamp=$(date +"%d.%m.%Y %H:%M:%S")
  # Write message with timestamp in the log file
  echo "$timestamp: $message" >> "$log_file"
}

# Check if logging_io_aero.log exists and delete it
if [ -f logging_io_aero.log ]; then
    rm -f logging_io_aero.log
fi

# Check if the file specified in logfile exists and delete it
if [ -f "${log_file}" ]; then
    rm -f "${log_file}"
fi

# Redirection of the standard output and the standard error output to the log file
exec > >(while read -r line; do log_message "$line"; done) 2> >(while read -r line; do log_message "ERROR: $line"; done)

echo "======================================================================="
echo "Start $0"
echo "-----------------------------------------------------------------------"
echo "IO_TEMPLATE-LIB - Template for Library Repositories."
echo "-----------------------------------------------------------------------"
echo "ENV_FOR_DYNACONF : ${ENV_FOR_DYNACONF}"
echo "PYTHONPATH       : ${PYTHONPATH}"
echo "-----------------------------------------------------------------------"
echo "TASK             : ${IO_AERO_TASK}"
echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "======================================================================="
# Task handling
# ---------------------------------------------------------------------------
case "${IO_AERO_TASK}" in
    "version")
	    if ! ( pipenv run python scripts/launcher.py -t "${IO_AERO_TASK}" ); then
            exit 255
        fi
        ;;

    *)
        echo "Processing of the script run_io_template_lib_pytest is aborted: unknown task='${IO_AERO_TASK}'"
        exit 255
        ;;
esac

echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "-----------------------------------------------------------------------"
echo "End   $0"
echo "======================================================================="

# Close the log file
exec > >(while read -r line; do echo "$line"; done) 2> >(while read -r line; do echo "ERROR: $line"; done)

# Closing the log file
log_message "Script finished."
