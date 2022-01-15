import os
import subprocess

from .config import *
from .print import *


def source_all():
    '''Source all shell files'''
    print_trace('Sourcing all')


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
        if VARS['SUDO']:
            return print_debug(f'\tsudo {cmd}')
            # return subprocess.run(f'sudo {cmd}', check=True, shell=True)
        else:
            return print_debug(f'\t{cmd}')
            # return subprocess.run(cmd, check=True, shell=True)
    except subprocess.CalledProcessError as e:
        raise NotImplementedError(
            f'Error in bash command: returncode={e.returncode}, stderr={e.stderr}')


def bash_cmd_tmp(cmd):
    try:
        if VARS['SUDO']:
            return subprocess.run(f'sudo {cmd}', check=True, shell=True)
        else:
            return subprocess.run(cmd, check=True, shell=True)
    except subprocess.CalledProcessError:
        return None
