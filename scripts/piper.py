#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

# Pipe output of two programs together

import argparse
import subprocess


def __main__():
    parser = argparse.ArgumentParser(prog="piper", description="Pipes output of two programs together.")
    parser.parse_args()

    p_ls = subprocess.Popen(['ls', '-lh'], stdout=subprocess.PIPE)
    p_wc = subprocess.Popen(['wc', '-c'], stdin=p_ls.stdout, stdout=subprocess.PIPE)

    # allow p_ls to receive a SIGPIPE if p_wc exits (ie wc failed)
    p_ls.stdout.close()

    # await results of the pipe
    output = p_wc.communicate()[0]

    # sample output:
    # ls:None, wc:0, output:1118
    print("ls:{ls_return}, wc:{wc_return}, output:{wc_output}".format(
        ls_return=p_ls.returncode, wc_return=p_wc.returncode,
        wc_output=output.strip()))


if __name__ == "__main__":
    __main__()