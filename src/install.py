import os
import sys
import traceback

from scripts import (apt, bin_files, home, lib, meta, pacman, private, repo,
                     share, shell, test)
from util.access import deactivate_sudo
from util.config import DOTFILES, VARS
from util.print import print_error, print_header
from util.types import LogLevel

script_map = {
    'meta': meta,
    'shell': shell,
    'home': home,
    'bin': bin_files,
    'lib': lib,
    'share': share,
    'repo': repo,
    'private': private
}

log_map = {
    'all': 1,
    'trace': 2,
    'debug': 3,
    'info': 4,
    'category': 5,
    'warn': 6,
    'error': 7,
    'fatal': 8,
    'off': 9
}


def install(args):
    caller_dir = os.getcwd()
    os.chdir(DOTFILES)
    deactivate_sudo()

    VARS.write = args['write']
    VARS.no_bash = args['nobash']
    VARS.submodule = args['sub']
    VARS.no_sudo = args['nosudo']
    VARS.print = LogLevel(log_map[args['log']])

    if args['apt']:
        install_script(apt, 'apt')
    elif args['pacman']:
        install_script(pacman, 'pacman')
    elif args['test']:
        install_script(test, 'test')
    elif args['script'] == 'all':
        for name, script in script_map.items():
            install_script(script, name)
    elif name := args['script']:
        install_script(script_map[name], name)
    deactivate_sudo()
    os.chdir(caller_dir)


def install_script(func, name):
    print_header(name)
    try:
        func()
    except Exception as error:
        print_error(f'Error encountered: {error}')
        while True:
            print('Continue(y/N)/Show traceback(t):', end=' ')
            choice = input()
            if choice in ['y', 'Y']:
                break
            if choice in ['t', 'T']:
                traceback.print_exc()
            else:
                sys.exit(1)
    os.chdir(DOTFILES)
