import os
import subprocess

from config import *
from print import *


def source_all():
    '''Source all shell files'''
    print('Sourcing all')


def run_script(path, name, args=[]):
    '''Return bash cmd stdout'''
    args = '"' + '" "'.join(args) + '"'
    cmd = f'./{name} {args}'
    os.chdir(path)
    out = subprocess.run(cmd, check=True, shell=True).stdout
    os.chdir(DOTFILES)
    return out


def cmd(cmd):
    '''Return bash cmd stdout'''
    print(f'\t{cmd}')
    # return subprocess.run(cmd, check=True, shell=True).stdout


def bash_tmp(cmd):
    return subprocess.run(cmd, check=True, shell=True)
