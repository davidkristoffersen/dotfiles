#!/usr/bin/env bash

dotfiles_pacman() {
	# AUR helper
	print_section "yay"
	echo "sudo pacman -S yay"

	local _pkg_path="$DOTFILES_SHARE/pacman"

	# AUR packages
	print_section "AUR"
	$PRINT && cat "$_pkg_path/foreign_table.txt"
	$PRINT && echo -e "\n"
	local _pkgs="$(cat "$_pkg_path/foreign.txt")"
	echo "yay -S $_pkgs"

	# Native packages
	print_section "Native" "\n"
	$PRINT && cat "$_pkg_path/native_table.txt"
	$PRINT && echo -e "\n"
	_pkgs="$(cat "$_pkg_path/native.txt")"
	echo "sudo pacman -S $_pkgs"
}

. $DOTFILES_SRC/init.sh dotfiles_pacman
