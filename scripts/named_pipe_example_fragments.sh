#!/usr/bin/env bash

# In the context of named pipes (fifos) the use of an additional file descriptor can enable non-blocking piping behaviour.

                (
    rm -f fifo
    mkfifo fifo

    #  open fifo for reading #
    exec 3<fifo

    trap "exit" 1 2 3 15
    exec cat fifo | nl
    ) &

bpid=$!

                (
    #  open fifo for writing #
    exec 3>fifo

    trap "exit" 1 2 3 15

    while true;
    do
        echo "blah" > fifo
    done
    )

#kill -TERM $bpid
