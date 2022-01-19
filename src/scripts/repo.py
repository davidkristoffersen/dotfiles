

from util.bash import bash_cmd, getenv, setenv
from util.config import VARS


def repo():
    '''Initialize submodules'''
    print()

    if not VARS.submodule:
        return

    if not getenv('SUBMODULE_INIT'):
        setenv('SUBMODULE_INIT', 'true')

    bash_cmd('git submodulepull')
