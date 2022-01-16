from .bash import *
from .config import *
from .print import *


def get_path_access(path):
    return path.startswith(HOME)


def activate_sudo(reason=''):
    if not bash_sudo_cmd('sudo -n true 2>/dev/null'):
        reason = reason if reason else 'Install requires sudo:'
        print_warn(reason, end='\n\t')
        if not bash_sudo_cmd('sudo -v'):
            raise NotImplementedError('Could not activate sudo')


def deactivate_sudo():
    bash_sudo_cmd('sudo -k')
    VARS.set_sudo(False)
