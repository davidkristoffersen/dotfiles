#!/usr/bin/env python3
'''Test dotfiles'''

from config import *
from util import *
from print import *


def test():
    '''test dotfiles'''
    foos = ['.foo', '.foo.d']
    bars = ['.bar', '.bar.d']

    print_section("Foo")
    for foo in foos:
        link_file(f'{DOTFILES_SHELL}/{foo}', foo, foo)

    print_section("Bar")
    for bar in bars:
        link_file(f'{DOTFILES_SHELL}/{bar}', bar, bar)


if __name__ == "__main__":
    pass
