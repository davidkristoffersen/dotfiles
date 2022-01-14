import subprocess

from config import *
from print import *


def link_file(src, dst, desc):
    '''Link file'''
    print(f'{BLUE}Replacing {desc}:{RESET}')
    print(f'ln -s "{src}" "{dst}"')


def source_all():
    '''Source all shell files'''
    print('Sourcing all')


def read(dst):
    '''Read file into list'''
    with open(dst, 'r') as _f:
        return _f.read().splitlines()


def write(data, dst):
    '''Write data to file'''
    with open(dst, 'w') as _f:
        print(f'Writing to {dst}')
        print(f'Data: {data}')


def run_script(path, name, args=[]):
    '''Return bash cmd stdout'''
    args = '"' + '" "'.join(args) + '"'
    cmd = f'./{name} {args}'
    os.chdir(path)
    out = subprocess.run(cmd, check=True, shell=True).stdout
    os.chdir(DOTFILES)
    return out


def bash(cmd):
    '''Return bash cmd stdout'''
    return subprocess.run(cmd, check=True, shell=True).stdout
