

from util.bash import run_script
from util.config import DOTFILES_SHARE
from util.print import print_section


def apt():
    '''Apt packages'''
    print_section('History')
    run_script(f'{DOTFILES_SHARE}/apt', 'install.sh',
               ['backup/history/lines_history.txt'])
    # run_script(f'{DOTFILES_SHARE}/apt', 'install_all.sh', ['backup/history/lines_history.txt'])
