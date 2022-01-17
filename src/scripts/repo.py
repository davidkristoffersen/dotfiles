from util.bash import *
from util.config import *
from util.file import *
from util.print import *


def repo():
    '''Initialize submodules'''
    print()

    if not VARS.submodule:
        return

    if not getenv('SUBMODULE_INIT'):
        setenv('SUBMODULE_INIT', 'true')

    bash_cmd('git submodulepull')
