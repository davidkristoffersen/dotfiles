#!/usr/bin/bash

_help() {
	INFO=true
}

win_link() {
	local src="$(realpath "$1")"
	local dst="$(realpath "$2")"

	local src_win="$(wslpath -w "$src")"
	local dst_win="$(wslpath -w "$dst")"

	local src_dir="$(dirname "$src")"
	local dst_win_dir="$(dirname "$dst_win")"

	local src_base="$(basename "$src")"
	local dst_win_base="$(basename "$dst_win")"

	cd "$dst"
	file_backup "$dst"
	file_remove "$dst"

	print_info "Win linking: \"$dst_win_base\" -> \"$src_base\""
	print_debug "Dirs: \"$dst_win_dir\" -> \"$src_dir\""
	win_cmd "mklink $dst_win $src_win"

	cd - >/dev/null
}

call_bash_func_if_exist $@
