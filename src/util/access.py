

from util.bash import bash_sudo_cmd
from util.config import HOME, VARS
from util.print import print_warn


def get_path_access(path):
    return path.startswith(HOME)


def activate_sudo(reason=''):
    if not bash_sudo_cmd('sudo -n true 2>/dev/null'):
        reason = reason if reason else 'Install requires sudo:'
        print_warn(reason + '\nRun command(Y/n)?:', end=' ')
        choice = input()
        if not choice in ['y', 'Y', '']:
            return False
        print(end='\t')
        if not bash_sudo_cmd('sudo -v'):
            raise NotImplementedError('Could not activate sudo')
        return True
    return True


def deactivate_sudo():
    bash_sudo_cmd('sudo -k')
    VARS.set_sudo(False)
