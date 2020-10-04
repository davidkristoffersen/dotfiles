#!/usr/bin/bash

dotfiles_submodules() {
	echo

	$SUBMODULE || return 0
	git submodulepull; check_error $?
}

. $DOTFILES_SRC/init.sh dotfiles_submodules
