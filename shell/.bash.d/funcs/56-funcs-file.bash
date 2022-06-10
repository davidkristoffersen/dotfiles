#!/usr/bin/bash

file_update() {
	_file_helper "$1" "$2"

	backup "$dst"

	print_info "Updating: \"$src_base\" -> \"$dst_base\""
	print_debug "Dirs: \"$src_dir\" -> \"$dst_dir\""
	cp "$src" "$dst"
}

file_backup() {
	_file_helper "$1"

	print_info "Backup: $base"
	print_debug "Dir: $dir"
	sudo cp -f "$path" "$path.bak" 2>/dev/null
}

file_remove() {
	_file_helper "$1"

	print_info "Removing: $base"
	print_debug "Dir: $dir"
	sudo rm -f "$path" 2>/dev/null
}

_file_helper() {
	if [ $# -eq 1 ]; then
		path="$(realpath "$1")"
		dir="$(dirname "$path")"
		base="$(basename "$path")"
	elif [ $# -eq 2 ]; then
		src="$(realpath "$1")"
		dst="$(realpath "$2")"

		src_dir="$(dirname "$src")"
		src_base="$(basename "$src")"

		dst_dir="$(dirname "$dst")"
		dst_base="$(basename "$dst")"
	fi
}

call_bash_func_if_exist $@
