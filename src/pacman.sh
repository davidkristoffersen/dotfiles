#!/usr/bin/env bash

dotfiles_pacman() {
	# AUR helper
	print_section "yay"
	echo "sudo pacman -S yay"

	# AUR packages
	print_section "AUR"
	pacman_manager.py foreign print
	echo
	local _pkgs="$(pacman_manager.py foreign)"
	echo "yay -S $_pkgs"

	# Native packages
	print_section "Native" "\n"
	pacman_manager.py native print
	echo
	_pkgs="$(pacman_manager.py native)"
	echo "sudo pacman -S $_pkgs"
}

. $DOTFILES_SRC/init.sh dotfiles_pacman
