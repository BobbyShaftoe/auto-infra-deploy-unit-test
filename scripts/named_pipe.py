#!/usr/bin/env/python
# coding: utf-8

class SimpleTask(object):
    def __or__(self, other):
        return self


class ComplexTask(object):
    def __or__(self, other):
        return self


def main():
    s = SimpleTask()
    c = ComplexTask()

    print s | c
    print c | s


if __name__ == '__main__':
    main()


