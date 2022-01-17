import os
import subprocess
from os import listdir
from os.path import isdir, isfile
from typing import Union

from toolz import curry, flip, pipe
from toolz.curried import filter, map

from .config import *
from .print import *


def source_all():
    '''Source all shell files'''
    source_util()
    source_profile()
    source_bashrc()


def source_util():
    bash_cmd(f'. "{DOTFILES_SHELL}/.util"')


def source_profile():
    bash_cmd(f'. "{DOTFILES_SHELL}/.profile"')


def source_bashrc():
    bash_cmd(f'. "{DOTFILES_SHELL}/.bashrc"')


@curry
def path_combine(base, path):
    return f'{base}/{path}'


def ls_files(path: str):
    return ls_type(path, isfile)


def ls_dirs(path: str):
    return ls_type(path, isdir)


def ls_type(path: str, func: Union[isfile, isdir]):
    return list(pipe(
        listdir(path),
        map(path_combine(path)),
        filter(func)
    ))


def getenv(name):
    return str(os.getenv(name))


def setenv(name, value):
    os.environ[name] = str(value)


def run_script(path, name, args=[]):
    '''Return bash cmd stdout'''
    args = '"' + '" "'.join(args) + '"'
    cmd = f'./{name} {args}'
    os.chdir(path)
    out = bash_cmd(cmd).stdout
    os.chdir(DOTFILES)
    return out


def bash_cmd(cmd):
    '''Return bash cmd stdout'''
    try:
        hardcoded = False
        if not VARS.sudo and cmd[:5] == 'sudo ':
            hardcoded = True
            VARS.set_sudo(True, f'Command requires sudo: "{cmd}"')
            cmd = cmd[5:]
        if VARS.sudo:
            cmd = f'sudo {cmd}'
        out = print_debug(f'\t{cmd}')
        # out = subprocess.run(cmd, check=True, shell=True)
        if hardcoded:
            VARS.set_sudo(False)
        return out
    except subprocess.CalledProcessError as e:
        raise NotImplementedError(
            f'Error in bash command: returncode={e.returncode}, stderr={e.stderr}')


def bash_sudo_cmd(cmd):
    try:
        return subprocess.run(cmd, check=True, shell=True)
    except subprocess.CalledProcessError:
        return None