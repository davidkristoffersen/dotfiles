import os

from config import *
from print import print_header
from scripts import *
from util import *


class Install():
    def __init__(self, script=False, server=False, test=False):
        self.script = script
        self.server = server
        self.test = test

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

        self.caller_dir = os.getcwd()
        self.script_dir = pathlib.Path(__file__).parent.resolve()
        os.chdir(DOTFILES)

    def run(self):
        if self.script:
            self.run_script(self.script_map[self.script], self.script)
        elif self.test:
            self.run_script(test, 'test')
        else:
            for name, script in self.script_map.items():
                self.run_script(script, name)

    def run_script(self, func, name):
        print_header(name)
        func()
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
