#!/bin/bash

# Simple shell script to test reading and writing from a pipe during build on a Jenkins server
# NOTE:
# Whatever is writing to the pipe typically writes '--- END OF FILE ---' signalling to this script to exit
#

if ps ax | egrep -v "grep|$$" | grep ${0}; then
  echo "I'm already running. Exiting..."
  exit 0
fi

pipe="${1}"
pipe_path=`dirname "${pipe}"`
pipe_name=`basename "${pipe}"`

[ ! -e "$pipe" ] && mkfifo ${pipe} || true
[ ! -e "$pipe" ] && { echo "FIFO / Named Pipe: $pipe  does not exist"; exit 1; }

count=0
trap "exit" 1 2 3 15


exec 3< ${pipe}
#exec > >(tee -i comms/jenkins_log)

while true; do

  if read line < ${pipe}; then
    count=$((count+1))
    echo "${count}: $(date '+%H:%M:%S'): $line" >>  comms/jenkins_log  2>&1

        if [ "${line}" ==  '--- END OF FILE ---' ]; then
	    count=$((count+1))
            echo "${count}: Finished Time: $(date '+%H:%M:%S')" >>  comms/jenkins_log 2>&1
        fi
  fi



  sleep 0.1

done
