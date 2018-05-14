#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})
DS3_EXEC=ds3-xboxdrv.sh
JSTEST_EXEC=jstest-gtk

EXECUTABLES=("${DS3_EXEC}" "${JSTEST_EXEC}")

ls -p | grep / | parallel 'cd {} && ./run.sh'

# for executable in ${EXECUTABLES[*]}; do
#     echo ${executable}
# done
