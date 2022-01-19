

from util.config import DOTFILES_LIB, XDG_LIB_HOME
from util.file import link_dir


def lib():
    '''Lib dotfiles'''
    print()

    # Bash library
    link_dir(f'{DOTFILES_LIB}/bash',
             f'{XDG_LIB_HOME}/bash', 'bash script library')
