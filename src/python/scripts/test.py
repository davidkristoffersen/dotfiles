from config import *
from print import *
from util import *


def test():
    '''Test dotfiles'''
    foos = ['.foo', '.foo.d']
    bars = ['.bar', '.bar.d']

    print_section("Foo")
    for foo in foos:
        link_file(f'{DOTFILES_SHELL}/{foo}', foo, foo)

    print_section("Bar")
    for bar in bars:
        link_file(f'{DOTFILES_SHELL}/{bar}', bar, bar)
