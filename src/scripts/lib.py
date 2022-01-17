from util.config import *
from util.crud import *
from util.print import *


def lib():
    '''Lib dotfiles'''
    print()

    # Bash library
    link_dir(f'{DOTFILES_LIB}/bash',
             f'{XDG_LIB_HOME}/bash', 'bash script library')
