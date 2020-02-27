#!/usr/bin/env bash

link_lib() {
	echo

	# Bash library
	link_file "$DOTFILES_LIB/bash" "$XDG_LIB_HOME/bash" "bash script library"
}

. $DOTFILES_SRC/init.sh
[ $? -ne 0 ] && return 1
link_lib
. $DOTFILES_SRC/fini.sh
