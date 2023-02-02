#!/usr/bin/bash

_source_funcs() {
	local dir="$DOTFILES_SHELL/.bash.d/source-funcs"

	for file in $(ls -A1 "$dir" | grep -e ".*\.bash"); do
		. "$dir/$file"
		check_error 0
	done
}

_source_funcs
unset -f _source_funcs
