import os
import sys
import traceback

from scripts import *
from util.access import *
from util.config import *
from util.crud import *
from util.print import print_header
from util.types import *


class Install():
    def __init__(self, args):
        self.script = args['script']
        self.apt = args['apt']

        self.write = args['write']
        self.log = args['log']
        self.sub = args['sub']
        self.test = args['test']
        self.server = args['server']
        self.pacman = args['pacman']

        self.script_map = {
            'meta': meta,
            'shell': shell,
            'home': home,
            'bin': bin,
            'lib': lib,
            'share': share,
            'repo': repo,
            'private': private
        }

        self.server_map = {
            'meta': meta,
            'shell': shell,
            'home': home,
            'bin': bin,
            'lib': lib,
            'share': share,
            'repo': repo,
            'private': private
        }

        self.log_map = {
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

        self.caller_dir = os.getcwd()
        self.script_dir = pathlib.Path(__file__).parent.resolve()
        os.chdir(DOTFILES)
        deactivate_sudo()

    def run(self):
        if self.log:
            VARS.print = LogLevel(self.log_map[self.log])
        if self.write:
            VARS.write = self.write
        if self.sub:
            VARS.submodule = self.sub
        if self.script:
            self.run_script(self.script_map[self.script], self.script)
        elif self.apt:
            self.run_script(apt, 'apt')
        elif self.pacman:
            self.run_script(pacman, 'pacman')
        elif self.test:
            self.run_script(test, 'test')
        elif self.server:
            for name, script in self.server_map.items():
                self.run_script(script, name)
        else:
            for name, script in self.script_map.items():
                self.run_script(script, name)
        deactivate_sudo()

    def run_script(self, func, name):
        print_header(name)
        try:
            func()
        except Exception as e:
            print_error(f'Error encountered: {e}')
            while True:
                print('Continue(y/N)/Show traceback(t):', end=' ')
                choice = input()
                if choice in ['y', 'Y']:
                    break
                elif choice in ['t', 'T']:
                    traceback.print_exc()
                else:
                    sys.exit(1)
        os.chdir(DOTFILES)
