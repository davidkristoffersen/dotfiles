import os
import subprocess
from os import listdir
from os.path import isdir, isfile

from util.config import DOTFILES, DOTFILES_SHELL, VARS
from util.print import print_debug, print_warn


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


def path_combine(base, path):
    return f'{base}/{path}'


def ls_files(path: str):
    return ls_type(path, isfile)


def ls_dirs(path: str):
    return ls_type(path, isdir)


def ls_type(path: str, func):
    files = [path_combine(path, _f) for _f in listdir(path)]
    return [_f for _f in files if func(_f)]


def getenv(name):
    return str(os.getenv(name))


def setenv(name, value):
    os.environ[name] = str(value)


def run_script(path, name, args=[]):
    '''Return bash cmd stdout'''
    args = '"' + '" "'.join(args) + '"'
    cmd = f'./{name} {args}'
    os.chdir(path)
    bash_cmd(cmd)
    os.chdir(DOTFILES)


def bash_cmd(cmd):
    '''Return bash cmd stdout'''
    try:
        hardcoded = False
        if not VARS.sudo and cmd[:5] == 'sudo ':
            if VARS.no_sudo:
                print_warn(
                    f'Cannot run sudo command with "--no-sudo" flag: "{cmd}"')
                return
            hardcoded = True
            if not VARS.set_sudo(True, f'Command requires sudo: "{cmd}"'):
                print_warn(
                    f'Failed to set sudo for command: "{cmd}"')
                return
            cmd = cmd[5:]
        if VARS.sudo:
            cmd = f'sudo {cmd}'
        print_debug(f'\t{cmd}')
        if not VARS.no_bash:
            print('COMMAND EXECUTED')
            subprocess.run(cmd, check=True, shell=True)
        if hardcoded:
            VARS.set_sudo(False)
        return
    except subprocess.CalledProcessError as error:
        raise NotImplementedError(
            f'Error in bash command: returncode={error.returncode}, stderr={error.stderr}') from error


def bash_sudo_cmd(cmd):
    try:
        return subprocess.run(cmd, check=True, shell=True)
    except subprocess.CalledProcessError:
        return None
