#!/usr/bin/bash

dotfiles_submodules() {
	echo

	$SUBMODULE || return 0

	if ! $SUBMODULE_INIT; then
		export SUBMODULE_INIT=true
	fi
	git submodulepull; check_error $?
}

. $DOTFILES_SRC/init.sh dotfiles_submodules
