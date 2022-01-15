from .bash import *
from .config import *
from .print import *


def get_path_access(path):
    if not path.startswith(HOME):
        activate_sudo(f'Path requires sudo: "{path}"')


def activate_sudo(reason=''):
    if not bash_cmd_tmp('sudo -n true 2>/dev/null'):
        reason = reason if reason else 'Install requires sudo:'
        print_warn(reason, end='\n\t')
        if not bash_cmd_tmp('sudo -v'):
            raise NotImplementedError('Could not activate sudo')


def deactivate_sudo():
    bash_cmd_tmp('sudo -k')
