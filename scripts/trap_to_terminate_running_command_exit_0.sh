#!/usr/bin/env bash

# avoid hangup or "broken pipe" error message when parent process set SIGPIPE to be ignored
# set exit code of yes subshell to 0
(
trap "" PIPE
   (
      trap 'trap - TERM; echo "kill from yes subshell ..." 1>&2; kill "${!}"; exit 0' TERM
      subshell_pid="$(bash -c 'echo "$PPID"')"
      (sleep 0; exec yes) & echo "${subshell_pid}"; wait ${!}
   ) |
   (
      trap 'trap - EXIT; kill -s TERM "$subshell_pid"; exit' EXIT
      subshell_pid="$(head -n 1)"
      head -n 10  # replacement for ./MyScript.sh
   )
echo ${PIPESTATUS[*]}
)