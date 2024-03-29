

from util.config import DOTFILES_CONFIG, DOTFILES_ETC, DOTFILES_HOME
from util.file import link_dir, link_file
from util.print import print_section


def home():
    '''Home dotfiles'''
    print_section('Git')
    # Config
    link_file(f'{DOTFILES_HOME}/.gitconfig', '.gitconfig', 'git config')

    print_section('Session management')
    # I3
    link_file(f'{DOTFILES_CONFIG}/i3/i3.config',
              '.config/i3/config', 'i3 config - Window manager')
    # Rofi
    link_file(f'{DOTFILES_CONFIG}/rofi/rofi.rasi',
              '.config/rofi/config.rasi', 'rofi config - Application launcher')
    # Terminator
    link_file(f'{DOTFILES_CONFIG}/terminator/terminator.ini',
              '.config/terminator/config', 'terminator config - Terminal emulator')
    # Alacritty
    link_file(f'{DOTFILES_CONFIG}/alacritty/alacritty.yml',
              '.config/alacritty/alacritty.yml', 'Alacritty config - Terminal emulator')
    # Tmux
    link_file(f'{DOTFILES_HOME}/.tmux.conf', '.tmux.conf',
              '.tmux.conf - Terminal multiplexer')
    # Dunst
    link_file(f'{DOTFILES_CONFIG}/dunst/dunst.cfg',
              '.config/dunst/dunstrc', 'Dunst config - Notification manager')
    # LightDM
    link_file(f'{DOTFILES_ETC}/lightdm.conf', '/etc/lightdm.conf',
              'lightdm config - Display manager')
    # Hushlogin
    link_file(f'{DOTFILES_HOME}/.hushlogin', '.hushlogin',
              'File to prevent daily login message')

    print_section('CLI configuration')
    # Readline
    link_file(f'{DOTFILES_HOME}/.inputrc', '.inputrc', 'readline config')
    # Xresources
    link_file(f'{DOTFILES_HOME}/.Xresources',
              '.Xresources', 'Xresources config')
    # xinit
    link_file(f'{DOTFILES_HOME}/.xinitrc', '.xinitrc', 'xinit config')
    # LS_COLOR
    link_file(f'{DOTFILES_HOME}/.dir_colors', '.dir_colors', 'LS_COLOR config')
    # EXA_COLOR
    link_file(f'{DOTFILES_CONFIG}/exa/.dir_colors',
              '.config/exa/.exa_colors', 'EXA_COLOR config')
    link_file(f'{DOTFILES_CONFIG}/exa/.dir_colors_extra',
              '.config/exa/.exa_colors_extra', 'EXA_COLOR extra config')

    print_section('Editor')
    # Vimrc files
    link_dir(f'{DOTFILES_HOME}/.vim', '.vim', 'vim dir config')
    link_file(f'{DOTFILES_HOME}/.vim/.vimrc', '.vimrc', 'vim config')
    # Neovim configs
    link_file(f'{DOTFILES_CONFIG}/nvim/init.lua',
              '.config/nvim/init.lua', 'neovim config')
    # link_file(f'{DOTFILES_CONFIG}/nvim/init.vim',
    #   '.config/nvim/init.vim', 'neovim lua config')
    # Latex
    link_file(f'{DOTFILES_CONFIG}/latex/template.latex',
              '.config/latex/template.latex', 'Latex template')
    # Pylint
    link_file(f'{DOTFILES_HOME}/.pylintrc', '.pylintrc', 'Pylint config')

    print_section('CLI programs')
    # SQLite
    link_file(f'{DOTFILES_HOME}/.sqliterc.sql', '.sqliterc', 'SQLite config')
    # Htop
    link_file(f'{DOTFILES_CONFIG}/htop/htoprc',
              '.config/htop/htoprc', 'htop config')

    print_section('GUI programs')
    # GIMP
    link_file(f'{DOTFILES_HOME}/.gimp-2.0/gimprc',
              '.gimp-2.0/gimprc', 'GIMP config')
    # Gitk
    link_file(f'{DOTFILES_CONFIG}/git/gitk', '.config/git/gitk', 'gitk config')
