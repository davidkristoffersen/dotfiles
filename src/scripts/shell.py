

from util.config import DOTFILES_SHELL
from util.file import link_dir, link_file
from util.print import print_section


def shell():
    '''Shell dotfiles'''
    print_section("Util")
    create_links(['.util', '.util.d'])

    print_section("Profile")
    create_links(['.bash_profile', '.profile', '.profile.d'])

    print_section("Bash")
    create_links(['.bashrc', '.bash.d', '.bash_completion.d', '.bash_logout'])

    print_section("Source")
    # source_all()


def create_links(links):
    for link in links:
        if link[-2:] == '.d':
            link_dir(f'{DOTFILES_SHELL}/{link}', link)
        else:
            link_file(f'{DOTFILES_SHELL}/{link}', link)
