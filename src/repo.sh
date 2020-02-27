#!/usr/bin/env bash

update_submodules() {
	echo
	$SUBMODULE || return
	git submodulepull; check_error $?
}

. $DOTFILES_SRC/init.sh
[ $? -ne 0 ] && return 1
update_submodules
. $DOTFILES_SRC/fini.sh
