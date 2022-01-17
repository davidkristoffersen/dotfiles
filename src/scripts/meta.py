
from util.config import *
from util.file import *
from util.print import *


def meta():
    '''Meta exports'''
    print()

    src = f'{DOTFILES_SRC}/util/meta.sh'
    dst = f'{HOME}/.dotfiles_meta.sh'
    out = f'export DOTFILES="{DOTFILES}"'
    src_file = read(src)

    pre = '\n'.join(src_file[0:2])
    post = '\n'.join(src_file[2:])
    out = f'{pre}\n{out}\n\n{post}'
    write(dst, out)
