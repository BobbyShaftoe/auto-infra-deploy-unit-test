#!/usr/bin/env bash


# In the context of named pipes (fifos) the use of an additional file descriptor
# # can enable non-blocking piping behaviour.

    (
        rm -f fifo
        mkfifo fifo
        exec 3<fifo   # open fifo for reading
        trap "exit" 1 2 3 15
        exec cat fifo | nl
    ) &
bpid=$!

    (
        exec 3>fifo  # open fifo for writing
        trap "exit" 1 2 3 15
        while true;
        do
            echo "blah" > fifo
        done
    )
#kill -TERM $bpid


# ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---


# BEWARE, BASHISM AHEAD (there are posix shells that are significantly faster than bash,
# e.g. ash or dash, that don't have process substitution).

# You can do a handle dance to move original standard output to a new descriptor
# to make standard output available for piping (from the top of my head):

exec 3>&1 # creates 3 as alias for 1
run_in_subshell() { # just shortcut for the two cases below
    echo "This goes to STDOUT" >&3
    echo "And this goes to THE OTHER FUNCTION"
}

# Now you should be able to write:

while read line; do
    process $line
done < <(run_in_subshell)

# but the <() construct is a bashism. You can replace it with pipeline



run_in_subshell | while read line; do
    process $line
done

# except than the second command also runs in subshell, because all commands in pipeline do.

# ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---


# The easiest way of course, is to capture the output directly in the parent

data_from_subshell=$(echo "This is the data I want to pass to the parent shell")

# You can use a named pipe as an alternative way to read data from a child

mkfifo /tmp/fifo
# now you can redirect the child to /tmp/fifo

(
    echo "This should go to STDOUT"
    echo "This is the data I want to pass to the parent shell" >/tmp/fifo
) &
# and the parent can read from there

read data_from_subshell </tmp/fifo


# ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---


# Another way is to use coproc to start a child process.
# This creates a child with a bidirectional pipe and redirects the child's stdin and stdout to the pipe descriptors.
# To use both the pipe and stdout in the child, you must duplicate stdout in the parent first

exec 4>&1 # duplicate stdout for usage in client

coproc SUBSHELL (
    exec 3>&1 1>&4- # redirect fd 3 to pipe, redirect fd 1 to stdout
    (
    echo "This should go to STDOUT"
    echo "This is the data I want to pass to the parent shell" >&3
    )
)

# close fd 4 in parent
exec 4>&-

read data <&${SUBSHELL[0]}

echo "Parent: $data"

# Coprocesses were introduced in Bash 4.0.


# ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---

# Here's yet another scenario when using an additional file descriptor seems appropriate (in Bash):
# Shell script password security of command-line parameters

env -i bash --norc   # clean up environment
set +o history
read -s -p "Enter your password: " passwd
exec 3<<<"$passwd"
mycommand <&3  # cat /dev/stdin in mycommand


# ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---



# Another, simpler use case is filtering the error output of a command.

# exec M>&N redirects a file descriptor to another one for the remainder of the script
# (or until another such command changes the file descriptors again).
# # There is some overlap in functionality between exec M>&N and somecommand M>&N.
#  The exec form is more powerful in that it does not have to be nested:

exec 8<&0 9>&1
exec >output12
command1
exec <input23
command2
exec >&9
command3
exec <&8


# Other examples that may be of interest:

# What does “3>&1 1>&2 2>&3” do in a script? (it swaps stdout with stderr)
# File descriptors & shell scripting
# How big is the pipe buffer?
# Bash script testing if a command has run correctly
# And for even more examples:

# questions tagged io-redirection
# questions tagged file-descriptors
# search for examples on this site in the Data Explorer (a public read-only copy of the Stack Exchange database)