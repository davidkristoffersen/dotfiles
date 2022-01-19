

from genericpath import isdir
from util.bash import bash_cmd
from util.config import DOTFILES_PRIVATE, DOTFILES_SHELL
from util.file import link_dir, write
from util.print import print_section


def private():
    '''Private dotfiles'''

    name = 'dotfiles_secrets'

    print_section('Clone repo')
    repo = f'https://github.com/davidkristoffersen/{name}.git'

    if not isdir(f'{DOTFILES_PRIVATE}/{name}'):
        bash_cmd(f'git clone {repo} "{DOTFILES_PRIVATE}/{name}"')

    print_section('Link repo')
    link_dir(f'{DOTFILES_PRIVATE}/{name}', name)

    print_section('Shell source')
    secret_body = '#!/usr/bin/env bash\n\n'
    secret_body += f'. \\"\\$DOTFILES_PRIVATE/{name}/.bashrc\\"'
    write(f'{DOTFILES_SHELL}/.bash.d/.90-secrets.bash', secret_body)
