import os

from .bash import *
from .config import *
from .print import *
from .wrap import *


# Create
@decor_path
def create_file(path, data):
    if os.path.isfile(path):
        raise NotImplementedError(f'File already exist: "{path}"')
    if VARS.write:
        print_info(f'Creating file: "{path}"')
        bash_cmd(f'touch "{path}"')
        bash_cmd(f'printf "{data}" > "{path}"')


@decor_path
def create_path(path):
    if VARS.write and not os.path.isdir(path):
        bash_cmd(f'mkdir -p "{path}"')


@decor_path_args(DOTFILES, HOME)
def link_file(src, dst, desc=''):
    '''Link file'''
    if not VARS.write:
        return
    if not os.path.isfile(src):
        raise NotImplementedError(f'Source file not found: "{src}"')
    link(src, dst, desc)


@decor_path_args(DOTFILES, HOME)
def link_dir(src, dst, desc=''):
    '''Link file'''
    if not VARS.write:
        return
    if not os.path.isdir(src):
        raise NotImplementedError(f'Source directory not found: "{src}"')
    link(src, dst, desc, False)


def link(src, dst, desc, is_file=True):
    if os.path.islink(dst):
        link_dst = os.readlink(dst)
        if not link_dst == src:
            print_warn(f'Link already exist: {dst} -> {link_dst}')
            print_warn('Replace the link(y/N)?', end=' ')
            choice = input()
            if not choice in ['y', 'Y']:
                print_debug('...Skipping')
                return
        else:
            return
    elif os.path.isfile(dst):
        print_warn(f'Destination already exist: {dst}')
        print_warn('Replace the file(y/N)?', end=' ')
        choice = input()
        if not choice in ['y', 'Y']:
            print_debug('...Skipping')
            return
    elif os.path.isdir(dst):
        raise NotImplementedError(f'Destination is a directory: "{dst}"')

    if desc:
        print_info(f'Replacing {desc}:')
    else:
        _type = 'file' if is_file else 'dir'
        desc = base_name(dst)
        print_info(f'Replacing {_type}: "{desc}"')

    create_path(dir_name(dst))
    rm_file(dst)
    bash_cmd(f'ln -s "{src}" "{dst}"')


# Read
@decor_path
def read(path):
    '''Read file into list'''
    with open(path, 'r') as _f:
        print_debug(f'\tReading from: "{path}"')
        return _f.read().splitlines()


# Update
@decor_path
def write(path, data):
    '''Write data to file'''
    if not VARS.write:
        return
    with open(path, 'w') as _f:
        print_debug(f'\tWriting to: "{path}"')
        print_trace(f'\tData: {data}')


# Delete
@decor_path
def rm_file(path):
    if VARS.write and os.path.isfile(path):
        bash_cmd(f'rm "{path}"')