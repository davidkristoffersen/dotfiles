from config import *
from print import *
from util import *


def apt():
    '''Apt packages'''
    print_section('Git')
    # Config
    link_file(f'{DOTFILES_HOME}/.gitconfig', '.gitconfig', '.gitconfig')

    print_section('Session management')
    # I3
    link_file(f'{DOTFILES_CONFIG}/i3/i3.config',
              '.config/i3/config', 'i3 config - Window manager')
