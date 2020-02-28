#!/usr/bin/env bash

main() {
	. $DOTFILES_SRC/init.sh
	[ $? -ne 0 ] && return 1

	print_header "Shell dotfiles"
	. $DOTFILES_SRC/shell.sh
	print_header "\$HOME dotfiles" "\n"
	. $DOTFILES_SRC/home.sh; check_error $?
	print_header "Shell scripts" "\n"
	. $DOTFILES_SRC/bin.sh; check_error $?
	print_header "Shell libraries" "\n"
	. $DOTFILES_SRC/lib.sh; check_error $?
	print_header "Shell shared data" "\n"
	. $DOTFILES_SRC/share.sh; check_error $?
	print_header "Update submodules" "\n"
	. $DOTFILES_SRC/repo.sh; check_error $?

	. $DOTFILES_SRC/fini.sh
}
main
