#!/usr/bin/bash

_bashrc() {
	. $HOME/.dotfiles_meta.sh
	[ $? -ne 0 ] && return
	local d_path="$DOTFILES_SHELL/.bash.d"

	for bash_file in $(ls -A1 "$d_path" | sort); do
		local file_path="$d_path/$bash_file"

		if [ "$bash_file" == ".gitignore" ] || [ -d "$file_path" ]; then
			continue
		fi

		. $file_path
		check_error 0
	done

	export SHELL_BASHRC=true
}

_checkloaded() {
	if [ "$SHELL_UTIL" != "true" ]; then
		. $HOME/.util
	fi
	if [ "$SHELL_PROFILE" != "true" ]; then
		. $HOME/.profile
	fi
}

_checkloaded
unset -f _checkloaded

_bashrc
unset -f _bashrc
