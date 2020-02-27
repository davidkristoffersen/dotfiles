#!/usr/bin/env bash

main() {
	. $DOTFILES_SRC/init.sh
	[ $? -ne 0 ] && return 1

	. $DOTFILES_SRC/shell.sh
	. $DOTFILES_SRC/home.sh
	. $DOTFILES_SRC/bin.sh
	. $DOTFILES_SRC/lib.sh
	. $DOTFILES_SRC/share.sh
	. $DOTFILES_SRC/repo.sh

	link_header "Shell dotfiles"
	link_shell
	echo
	link_header "\$HOME dotfiles"
	link_home
	echo
	link_header "Shell scripts"
	link_bin
	echo
	link_header "Shell libraries"
	link_lib
	echo
	link_header "Shell shared data"
	link_share
	echo
	link_header "Update submodules"
	update_submodules

	. $DOTFILES_SRC/fini.sh
}
main
