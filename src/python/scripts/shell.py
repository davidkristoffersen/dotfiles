from config import *
from print import *
from util import *


def shell():
    '''Shell dotfiles'''
    utils = ['.util', '.util.d']
    profiles = ['.bash_profile', '.profile', '.profile.d']
    bashs = ['.bashrc', '.bash.d', '.bash_completion.d', '.bash_logout']

    print_section("Util")
    for util in utils:
        link_file(f'{DOTFILES_SHELL}/{util}', util, util)

    print_section("Profile")
    for profile in profiles:
        link_file(f'{DOTFILES_SHELL}/{profile}', profile, profile)

    print_section("Bash")
    for bash_file in bashs:
        link_file(f'{DOTFILES_SHELL}/{bash_file}', bash_file, bash_file)

    print_section("Source")
    source_all()
