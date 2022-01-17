
from util.config import *
from util.crud import *
from util.print import *


def bin():
    '''Bin dotfiles'''

    print_section('Files')
    for _f in ls_files(DOTFILES_BIN):
        link_file(_f, f'{XDG_BIN_HOME}/{base_name(_f)}')

    print_section('Directories')
    for _d in ls_dirs(DOTFILES_BIN):
        link_dir(_d, f'{XDG_BIN_HOME}/{base_name(_d)}')
