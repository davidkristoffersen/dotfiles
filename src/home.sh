#!/usr/bin/env bash

# $HOME dotfiles
dotfiles_home() {
	print_section "Git"
	# Config
	link_file $DOTFILES_HOME/.gitconfig .gitconfig ".gitconfig"

	print_section "Session management"
	# I3
	link_file $DOTFILES_CONFIG/i3/i3.config .config/i3/config "i3 config - Window manager"
	# Rofi
	link_file $DOTFILES_CONFIG/rofi/rofi.rasi .config/rofi/config.rasi "rofi config - Application launcher"
	# Terminator
	link_file $DOTFILES_CONFIG/terminator/terminator.ini .config/terminator/config "terminator config - Terminal emulator"
	# Alacritty
	link_file $DOTFILES_CONFIG/alacritty/alacritty.yml .config/alacritty/alacritty.yml "Alacritty config - Terminal emulator"
	# Tmux
	link_file $DOTFILES_HOME/.tmux.conf .tmux.conf ".tmux.conf - Terminal multiplexer"
	# Dunst
	link_file $DOTFILES_CONFIG/dunst/dunst.cfg .config/dunst/dunstrc "Dunst config - Notification manager"
	# LightDM
	link_file $DOTFILES_ETC/lightdm.conf /etc/lightdm.conf "light config - Display manager"

	print_section "CLI configuration"
	# Readline
	link_file $DOTFILES_HOME/.inputrc .inputrc "readline config"
	# Xresources
	link_file $DOTFILES_HOME/.Xresources .Xresources "Xresources config"
	# xinit
	link_file $DOTFILES_HOME/.xinitrc .xinitrc "xinit config"
	# LS_COLOR
	link_file $DOTFILES_HOME/.dir_colors .dir_colors "LS_COLOR config"
	# EXA_COLOR
	link_file $DOTFILES_CONFIG/exa/.dir_colors .config/exa/.exa_colors "EXA_COLOR config"
	link_file $DOTFILES_CONFIG/exa/.dir_colors_extra .config/exa/.exa_colors_extra "EXA_COLOR extra config"

	print_section "Editor"
	# Vimrc files
	link_file $DOTFILES_HOME/.vim .vim "vim dir config"
	link_file $DOTFILES_HOME/.vim/.vimrc .vimrc "vim config"
	# Latex
	link_file $DOTFILES_CONFIG/latex/template.latex .config/latex/template.latex "Latex template"

	print_section "CLI programs"
	# SQLite
	link_file $DOTFILES_HOME/.sqliterc.sql .sqliterc "SQLite config"
	# Htop
	link_file $DOTFILES_CONFIG/htop/htoprc .config/htop/htoprc "htop config"

	print_section "GUI programs"
	# GIMP
	link_file $DOTFILES_HOME/.gimp-2.0/gimprc .gimp-2.0/gimprc "GIMP config"
	# Gitk
	link_file $DOTFILES_CONFIG/git/gitk .config/git/gitk "gitk config"
}

. $DOTFILES_SRC/init.sh dotfiles_home
