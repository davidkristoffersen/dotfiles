

from util.config import (DOTFILES, DOTFILES_BIN, DOTFILES_CONFIG, DOTFILES_ETC,
                         DOTFILES_HOME, DOTFILES_LIB, DOTFILES_PRIVATE,
                         DOTFILES_SHARE, DOTFILES_SHELL, DOTFILES_SRC, HOME)
from util.file import write


def meta():
    '''Meta exports'''
    print()

    out = '#!/usr/bin/bash\n\n'
    out += f'export DOTFILES="{DOTFILES}"\n\n'
    out += meta_export('DOTFILES_SHELL', DOTFILES_SHELL)
    out += meta_export('DOTFILES_SRC', DOTFILES_SRC)
    out += meta_export('DOTFILES_SHELL', DOTFILES_SHELL)
    out += meta_export('DOTFILES_HOME', DOTFILES_HOME)
    out += meta_export('DOTFILES_CONFIG', DOTFILES_CONFIG)
    out += meta_export('DOTFILES_BIN', DOTFILES_BIN)
    out += meta_export('DOTFILES_LIB', DOTFILES_LIB)
    out += meta_export('DOTFILES_SHARE', DOTFILES_SHARE)
    out += meta_export('DOTFILES_ETC', DOTFILES_ETC)
    out += meta_export('DOTFILES_PRIVATE', DOTFILES_PRIVATE)

    dst = f'{HOME}/.dotfiles_meta.sh'
    write(dst, out)


def meta_export(key, value):
    value = value[len(DOTFILES):]
    return f'export {key}=\\"\\$DOTFILES{value}\\"\n'
