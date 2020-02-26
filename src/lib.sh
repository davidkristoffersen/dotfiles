#!/usr/bin/env bash

link_lib() {
	echo

	# Bash library
	link_file "$DOTFILES_LIB/bash" "$XDG_LIB_HOME/bash" "bash script library"
}
