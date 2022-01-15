from util.bash import *
from util.config import *
from util.print import *


def apt():
    '''Apt packages'''
    print_section('History')
    run_script(f'{DOTFILES_SHARE}/apt', 'install.sh',
               ['backup/history/lines_history.txt'])
    # run_script(f'{DOTFILES_SHARE}/apt', 'install_all.sh', ['backup/history/lines_history.txt'])
