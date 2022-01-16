import os
import subprocess

from . import access
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
