#!/usr/bin/env bash

# Since yes and ./MyScript.sh can each be run in an explicit subshell,
# it is possible to background the yes command, send yespid to the ./MyScript.sh subshell,
# and then implement a trap on EXIT there to manually terminate the yes command.
# (The trap on EXIT should always be implemented in the subshell of the last command of a piped commmand sequence).

# avoid hangup or "broken pipe" error message when parent process set SIGPIPE to be ignored
# sleep 0 or cat /dev/null: do nothing but with external command (for a shell builtin command see: help :)

(
trap "" PIPE
( (sleep 0; exec yes) & echo ${!}; wait ${!} ) |
   (
     trap 'trap - EXIT; kill "$yespid"; exit 0' EXIT
     yespid="$(head -n 1)"
     head -n 10  # replacement for ./MyScript.sh
   )
echo ${PIPESTATUS[*]}
)