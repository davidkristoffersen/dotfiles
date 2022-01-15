import os
import pathlib

from .types import *

HOME = str(os.getenv('HOME'))
DOTFILES = str(pathlib.Path(__file__).parent.parent.parent.parent.resolve())

DOTFILES_SRC = f'{DOTFILES}/src'
DOTFILES_SHELL = f'{DOTFILES}/shell'
DOTFILES_HOME = f'{DOTFILES}/home'
DOTFILES_CONFIG = f'{DOTFILES}/home/.config'
DOTFILES_BIN = f'{DOTFILES}/bin'
DOTFILES_LIB = f'{DOTFILES}/lib'
DOTFILES_SHARE = f'{DOTFILES}/share'
DOTFILES_ETC = f'{DOTFILES}/etc'
DOTFILES_PRIVATE = f'{DOTFILES}/private'


global VARS
VARS = {
    'SUDO': False,
    'WRITE': False,
    'PRINT': LogLevel.DEBUG
}