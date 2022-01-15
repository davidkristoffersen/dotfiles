import os
import subprocess

from config import *
from print import *
from wrap import *

#
# CRUD operations
#


# Create
@decor_path
def create_file(path):
    pass


@decor_path
def create_path(path):
    if not os.path.isdir(path):
        bash(f'mkdir -p "{path}"')


@decor_path_args(DOTFILES, HOME)
def link_file(src, dst, desc=''):
    '''Link file'''
    if not os.path.isfile(src):
        raise NotImplementedError(f'Source file not found: "{src}"')
    link(src, dst, desc)


@decor_path_args(DOTFILES, HOME)
def link_dir(src, dst, desc=''):
    '''Link file'''
    if not os.path.isdir(src):
        raise NotImplementedError(f'Source directory not found: "{src}"')
    link(src, dst, desc, False)


def link(src, dst, desc, is_file=True):
    if desc:
        print(f'{BLUE}Replacing {desc}:{RESET}')
    else:
        _type = 'file' if is_file else 'dir'
        desc = base_name(dst)
        print(f'{BLUE}Replacing {_type} "{desc}":{RESET}')

    if os.path.isdir(dst):
        raise NotImplementedError(f'Destination is a directory: "{dst}"')
    create_path(dir_name(dst))
    rm_file(dst)

    bash(f'ln -s "{src}" "{dst}"')


# Read
def read(dst):
    '''Read file into list'''
    with open(dst, 'r') as _f:
        return _f.read().splitlines()


# Update
def write(data, dst):
    '''Write data to file'''
    with open(dst, 'w') as _f:
        print(f'Writing to "{dst}"')
        print(f'Data: {data}')


# Delete
@decor_path
def rm_file(path):
    if os.path.isfile(path):
        bash(f'rm "{path}"')


#
# Unix path
#

def sudo_path(path):
    pass


def base_name(path):
    return path.split('/')[-1]


def dir_name(path):
    return '/' + '/'.join(path.split('/')[1:-1])

#
# Bash commands
#


def activate_sudo():
    pass


def set_sudo():
    pass


def source_all():
    '''Source all shell files'''
    print('Sourcing all')


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
    print(f'\t{cmd}')
    # return subprocess.run(cmd, check=True, shell=True).stdout
