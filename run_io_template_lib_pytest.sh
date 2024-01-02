#!/bin/bash

set -e

# ------------------------------------------------------------------------------
#
# run_io_template_lib_pytest.sh: Process IO-TEMPLATE-LIB tasks.
#
# ------------------------------------------------------------------------------

if [ -z "${ENV_FOR_DYNACONF}" ]; then
    export ENV_FOR_DYNACONF=test
fi

export PYTHONPATH=.

rm -f logging_io_aero.log

echo "================================================================================"
echo "Start $0"
echo "--------------------------------------------------------------------------------"
echo "IO_TEMPLATE_LIB - Template Library."
echo "--------------------------------------------------------------------------------"
echo "ENV_FOR_DYNACONF : ${ENV_FOR_DYNACONF}"
echo "PYTHONPATH       : ${PYTHONPATH}"
echo "--------------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "================================================================================"

if ! ( pipenv run python scripts/launcher.py ); then
    exit 255
fi

echo "--------------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "--------------------------------------------------------------------------------"
echo "End   $0"
echo "================================================================================"
