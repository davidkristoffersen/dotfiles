#!/usr/bin/bash

_bashrc() {
	. $HOME/.dotfiles_meta.sh
	[ $? -ne 0 ] && return

	for bash_file in $(ls -A1 $DOTFILES_SHELL/.bash.d | sort); do
		if [ "$bash_file" == ".gitignore" ]; then
			continue
		fi

		. $DOTFILES_SHELL/.bash.d/$bash_file; check_error 0
	done

	export SHELL_BASHRC=true
}

_bashrc
unset -f _bashrc
