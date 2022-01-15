from config import *
from print import *

from .bash import *


def set_sudo():
    pass


def get_path_access(path):
    if not path.startswith(HOME):
        activate_sudo(f'Path requires sudo: "{path}"')


def activate_sudo(reason=''):
    try:
        bash_tmp('sudo -n true 2>/dev/null')
    except subprocess.CalledProcessError:
        reason = reason if reason else 'Install requires sudo:'
        print(f'{RED}{reason}{RESET}', end='\n\t')
        try:
            bash_tmp('sudo -v')
        except subprocess.CalledProcessError:
            raise NotImplementedError('Could not activate sudo')


def deactivate_sudo():
    bash_tmp('sudo -k')
