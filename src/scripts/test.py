from util.config import *
from util.crud import *
from util.print import *


def test():
    '''Test dotfiles'''
    print_section("Foo")
    create_links(['.foo', '.foo.d'])

    print_section("Bar")
    create_links(['.bar', '.bar.d'])


def create_links(links):
    for link in links:
        if link[-2:] == '.d':
            link_dir(f'{DOTFILES_SHELL}/{link}', link)
        else:
            link_file(f'{DOTFILES_SHELL}/{link}', link)
