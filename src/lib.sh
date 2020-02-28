#!/usr/bin/env bash

dotfiles_lib() {
	echo

	# Bash library
	link_file "$DOTFILES_LIB/bash" "$XDG_LIB_HOME/bash" "bash script library"
}

. $DOTFILES_SRC/init.sh dotfiles_lib
