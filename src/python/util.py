import subprocess
import os

from config import *
from print import *


def link_file(src, dst, desc=''):
    '''Link file'''
    if not os.path.isfile(src):
        print(f'Source file not found: "{src}"')
        return
    link(src, dst, desc)


def link_dir(src, dst, desc=''):
    '''Link file'''
    if not os.path.isdir(src):
        print(f'Source directory not found: "{src}"')
        return
    link(src, dst, desc, False)


def link(src, dst, desc, is_file=True):
    desc = desc if len(desc) else dst
    _type = ' file' if is_file else ' dir'
    _type = '' if not desc == dst else _type
    desc = f'"{desc}"' if _type else desc
    src = real_path(dotfiles_path(src))
    dst = real_path(home_path(dst))

    print(f'{BLUE}Replacing{_type} {desc}:{RESET}')
    if os.path.isdir(dst):
        print(f'Destination is a directory: "{dst}"')
        return
    create_path(dir_name(dst))
    if os.path.isfile(dst):
        rm_file(dst)

    print(f'\tln -s "{src}" "{dst}"')


def rm_file(path):
    if os.path.isfile(path):
        print(f'\trm "{path}"')


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
        print(f'Writing to "{dst}"')
        print(f'Data: {data}')


def run_script(path, name, args=[]):
    '''Return bash cmd stdout'''
    args = '"' + '" "'.join(args) + '"'
    cmd = f'./{name} {args}'
    os.chdir(path)
    out = subprocess.run(cmd, check=True, shell=True).stdout
    os.chdir(DOTFILES)
    return out


def home_path(path):
    return path if path[0] == '/' else f'{HOME}/{path}'

def dotfiles_path(path):
    return path if path[0] == '/' else f'{DOTFILES}/{path}'

def dir_name(path):
    if path == '/':
        return path
    return '/' + '/'.join(path.split('/')[1:-1])

def real_path(path):
    if path == '/':
        return path
    if path[0] != '/':
        path = home_path(path)
    dirs = path.split('/')[1:]
    out = ['/']
    for _dir in dirs:
        if _dir == '..' and not out[-1] == '/':
            out.pop()
        elif not _dir == '.' and not _dir == '..':
            out.append(_dir)
    return '/' + '/'.join(out[1:])

def create_path(path):
    path = real_path(path)
    if not os.path.isdir(path):
        print(f'\tmkdir -p "{path}"')


def bash(cmd):
    '''Return bash cmd stdout'''
    return subprocess.run(cmd, check=True, shell=True).stdout
