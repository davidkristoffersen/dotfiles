

from util.bash import ls_dirs, ls_files
from util.config import DOTFILES_BIN, XDG_BIN_HOME
from util.file import link_dir, link_file
from util.path import base_name
from util.print import print_section


def bin_files():
    '''Bin dotfiles'''

    print_section('Files')
    for _f in ls_files(DOTFILES_BIN):
        link_file(_f, f'{XDG_BIN_HOME}/{base_name(_f)}')

    print_section('Directories')
    for _d in ls_dirs(DOTFILES_BIN):
        link_dir(_d, f'{XDG_BIN_HOME}/{base_name(_d)}')
