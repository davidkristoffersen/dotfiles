from util.config import *
from util.crud import *
from util.print import *


def lib():
    '''Lib dotfiles'''
    print()

    xdg_lib_home = getenv('XDG_LIB_HOME')

    # Bash library
    link_dir(f'{DOTFILES_LIB}/bash',
             f'{xdg_lib_home}/bash', 'bash script library')
