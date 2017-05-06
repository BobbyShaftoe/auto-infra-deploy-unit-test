#!/bin/bash

DEFAULT_TIMEOUT=9
DEFAULT_INTERVAL=1
DEFAULT_DELAY=1

#pipe=./jenkins_logger_pipe
pipe="${1}"

while true; do

  if read line <$pipe; then
    echo $line
        if [ "${line}" ==  '--- END OF FILE ---' ]; then
            exit 0
        fi
  fi



  sleep 1

done