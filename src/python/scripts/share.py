from util.config import *
from util.crud import *
from util.print import *


def share():
    '''Share dotfiles'''
    print()

    xdg_data_home = getenv('XDG_DATA_HOME')

    # Bash metadata
    link_dir(f'{DOTFILES_SHARE}/bash-metadata',
             f'{xdg_data_home}/bash-metadata', 'bash metadata')

    # Backgrounds
    link_dir(f'{DOTFILES_SHARE}/backgrounds',
             f'{xdg_data_home}/backgrounds', 'backgrounds')

    # Rofi themes
    link_dir(f'{DOTFILES_SHARE}/rofi',
             f'{xdg_data_home}/rofi', 'rofi themes')
