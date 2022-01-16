import os

from scripts import *
from util.access import *
from util.config import *
from util.crud import *
from util.print import print_header
from util.types import *


class Install():
    def __init__(self, script=False, apt=False, test=False, write=False, log=False):
        self.script = script
        self.apt = apt
        self.test = test
        self.write = write
        self.log = log

        self.script_map = {
            'shell': shell,
            'home': home,
            # 'bin': bin,
            # 'lib': lib,
            # 'share': share,
            # 'repo': repo,
            # 'private': private,
            # 'pacman': pacman,
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
        if self.script:
            self.run_script(self.script_map[self.script], self.script)
        elif self.apt:
            self.run_script(apt, 'apt')
        elif self.test:
            self.run_script(test, 'test')
        else:
            for name, script in self.script_map.items():
                self.run_script(script, name)
        deactivate_sudo()

    def run_script(self, func, name):
        print_header(name)
        try:
            func()
        except Exception as e:
            print_error('Something went wrong')
            raise e
        os.chdir(DOTFILES)

        def meta_init(self):
            '''Meta init'''
            src = f'{DOTFILES_SRC}/config.py'
            dst = f'{HOME}/.dotfiles_meta.sh'

            out = f'export DOTFILES="{DOTFILES}"'
            src_file = read(src)
            pre = '\n'.join(src_file[0:2])
            post = '\n'.join(src_file[2:])
            out = f'{pre}\n\n{out}\n\n{post}'

            write(out, dst)
