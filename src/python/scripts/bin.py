from util.config import *
from util.crud import *
from util.print import *


def bin():
    '''Bin dotfiles'''
    print()

    xdg_bin_home = getenv('XDG_BIN_HOME')

    cwd = os.getcwd()
    os.chdir(DOTFILES_BIN)
    bash_cmd('shopt -s globstar')
    scripts = bash_cmd('ls -dA1 **')
    os.chdir(cwd)
    if not scripts:
        raise NotImplementedError(f'Directory empty: {DOTFILES_BIN}')

    for script in scripts.stdout.splitLines():
        base = base_name(script)
        link_file(f'{DOTFILES_BIN}/{script}', f'{xdg_bin_home}/{base}', script)
