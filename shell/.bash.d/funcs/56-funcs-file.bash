#!/usr/bin/bash

sudo_needed() {
	if [ ! -w "$1" ]; then
		sudo_activate
		check_error $?
	fi
}

sudo_activate() {
	sudo -v
	SUDO="sudo "
}

sudo_deactivate() {
	sudo -k
	SUDO=""
}

dir_create() {
	if [ ! -d "$1" ]; then
		_file_helper "$1"
		print_info "Creating dir: \"$base\""
		print_debug "Dir: \"$dir\""
		${SUDO}mkdir "$path"
	fi
}

file_create() {
	if [ ! -f "$1" ]; then
		_file_helper "$1"
		print_info "Creating file: \"$base\""
		print_info "Dir: \"$dir\""
		${SUDO}touch "$path"
	fi
}

file_copy_new() {
	if [ -f "$1" ] && [ ! -f "$2" ]; then
		_file_helper "$1" "$2"
		print_info "Copying new: \"$src_base\" -> \"$dst_base\""
		print_debug "Dirs: \"$src_dir\" -> \"$dst_dir\""
		${SUDO}cp "$src" "$dst"
	fi
}

file_overwrite() {
	_file_helper "$1" "$2"

	file_backup "$dst"

	print_info "Overwriting: \"$src_base\" -> \"$dst_base\""
	print_debug "Dirs: \"$src_dir\" -> \"$dst_dir\""
	${SUDO}cp "$src" "$dst"
}

file_backup() {
	if [ $# -eq 1 ]; then
		_file_helper "$1"

		print_info "Backup: \"$base\""
		print_debug "Dir: \"$dir\""
		${SUDO}cp -f "$path" "$path" 2>/dev/null
	elif [ $# -eq 2 ]; then
		_file_helper "$1" "$2"

		print_info "Backup: \"$src_base\" -> \"$dst_base\""
		print_debug "Dirs: \"$src_dir\" -> \"$dst_dir\""
		cp "$src" "$dst"
		${SUDO}cp -f "$path" "$path" 2>/dev/null
	fi
}

file_remove() {
	_file_helper "$1"

	print_info "Removing: \"$base\""
	print_debug "Dir: \"$dir\""
	${SUDO}rm -f "$path" 2>/dev/null
}

_file_helper() {
	SUDO=""
	if [ $# -eq 1 ]; then
		sudo_needed "$1"
		if [ -f "$1" ]; then
			path="$(realpath "$1")"
		else
			path="$1"
		fi
		dir="$(dirname "$path")"
		base="$(basename "$path")"
	elif [ $# -eq 2 ]; then
		sudo_needed "$1"
		sudo_needed "$2"
		src="$(realpath "$1")"

		if [ -f "$2" ]; then
			dst="$(realpath "$2")"
		else
			dst="$2"
		fi

		src_dir="$(dirname "$src")"
		src_base="$(basename "$src")"

		dst_dir="$(dirname "$dst")"
		dst_base="$(basename "$dst")"
	fi
}

call_bash_func_if_exist $@
