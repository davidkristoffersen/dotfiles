#!/usr/bin/env bash

dotfiles_bin() {
	echo

	cd $DOTFILES_BIN
	shopt -s globstar
	local _scripts="$(ls -dA1 **)"
	cd - >/dev/null

	for script in $_scripts; do
		if [ -f $DOTFILES_BIN/$script ]; then
			link_file "$DOTFILES_BIN/$script" "$XDG_BIN_HOME/$(basename $script)" "$script"
		fi
	done
}

. $DOTFILES_SRC/init.sh dotfiles_bin
