import os
import pathlib

from util.classes import Vars

HOME = str(os.getenv('HOME'))
DOTFILES = str(pathlib.Path(__file__).parent.parent.parent.resolve())


# Dotfiles structure
DOTFILES_SRC = f'{DOTFILES}/src'
DOTFILES_SHELL = f'{DOTFILES}/shell'
DOTFILES_HOME = f'{DOTFILES}/home'
DOTFILES_CONFIG = f'{DOTFILES}/home/.config'
DOTFILES_BIN = f'{DOTFILES}/bin'
DOTFILES_LIB = f'{DOTFILES}/lib'
DOTFILES_SHARE = f'{DOTFILES}/share'
DOTFILES_ETC = f'{DOTFILES}/etc'
DOTFILES_PRIVATE = f'{DOTFILES}/private'

# /etc
XDG_CONFIG_HOME = f'{HOME}/.config/'
# /var/cache
XDG_DATA_HOME = f'{HOME}/.local/share'
# /usr/share
XDG_CACHE_HOME = f'{HOME}/.cache'
# /usr/src
XDG_SRC_HOME = f'{HOME}/.src'
# /usr/bin
XDG_BIN_HOME = f'{HOME}/.local/bin'
# /usr/lib
XDG_LIB_HOME = f'{HOME}/.local/lib'


global VARS
VARS = Vars()
