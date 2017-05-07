#!/bin/bash

# Simple shell script to test reading and writing from a pipe during build on a Jenkins server
# NOTE:
# Whatever is writing to the pipe typically writes '--- END OF FILE ---' signalling to this script to exit
#
#DEFAULT_TIMEOUT=9
#DEFAULT_INTERVAL=1
#DEFAULT_DELAY=1

pipe="${1}"
[ ! -e "$pipe" ] && { echo "FIFO / Named Pipe: $pipe  does not exist"; exit 1; }

count=0
trap "exit" 1 2 3 15


exec 3< ${pipe}
exec > >(tee -i comms/jenkins_log)

while true; do

  if read line < ${pipe}; then

    echo "${count}: $(date '+%H:%M:%S'): $line"

        if [ "${line}" ==  '--- END OF FILE ---' ]; then
            exit 0
        fi
    count=$((count+1))
  fi

  echo "Finished Time: $(date '+%H:%M:%S')"


  sleep 0.5

done