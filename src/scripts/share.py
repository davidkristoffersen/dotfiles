

from util.config import DOTFILES_SHARE, XDG_DATA_HOME
from util.file import link_dir


def share():
    '''Share dotfiles'''
    print()

    # Bash metadata
    link_dir(f'{DOTFILES_SHARE}/bash-metadata',
             f'{XDG_DATA_HOME}/bash-metadata', 'bash metadata')

    # Backgrounds
    link_dir(f'{DOTFILES_SHARE}/backgrounds',
             f'{XDG_DATA_HOME}/backgrounds', 'backgrounds')

    # Rofi themes
    link_dir(f'{DOTFILES_SHARE}/rofi',
             f'{XDG_DATA_HOME}/rofi', 'rofi themes')
