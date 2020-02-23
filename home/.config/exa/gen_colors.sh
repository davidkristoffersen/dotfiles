#!/usr/bin/env bash

exa_dircolors() {
	local _file="$HOME/.config/exa/.exa_colors"
	local _file_extra="$HOME/.config/exa/.exa_colors_extra"

	test -f "$_file"
	check_error $?
	test -f "$_file_extra"
	check_error $?

	local parsed="$(dircolors -b "$_file" | head -n +1 | head -c -3 | tail -c +12)"

	a() {
		parsed+="$1=$2:"
	}

	while IFS= read -r line; do
		if [ -z "$line" ] || [ "${line:0:1}" == "#" ]; then
			continue
		fi
		IFS='#' read -ra line <<< "$line"
		line="${line[0]}"
		a $line
	done < "$_file_extra"

	printf "EXA_COLORS='$parsed';\nexport EXA_COLORS"
}

eval "$(exa_dircolors)"
