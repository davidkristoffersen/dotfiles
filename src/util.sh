#!/usr/bin/env bash

path_is_abs() {
	case $1 in
		/*) printf true ;;
		*) printf false ;;
	esac
}

path_set_pre() {
	if $(path_is_abs "$1"); then
		printf "$1"
	else
		printf "$2/$1"
	fi
}

path_need_sudo() {
	if $(path_is_abs $1) && ! [[ "$1" == $HOME* ]]; then
		printf true
	else
		printf false
	fi
}

eval_cmd() {
	local _cmd="$1"
	shift
	local _args="$@"

	$PRINT && printf "\t$_cmd $_args\n"
	! $WRITE || $_cmd $_args; check_error $?
	return 0
}

path_create() {
	local _sudo=""
	if $(path_need_sudo $1); then
		_sudo="sudo "
	fi
	$PRINT && printf "\t${_sudo}mkdir -p \"$1\"\n"
	! $WRITE || $_sudo mkdir -p "$1"; check_error $?
	return 0
}

rm_file() {
	local _sudo=""
	if $(path_need_sudo $1); then
		_sudo="sudo "
	fi
	$PRINT && printf "\t${_sudo}rm -f \"$1\"\n"
	! $WRITE || $_sudo rm -f "$1"; check_error $?
	return 0
}

create_file() {
	local _path="$1"
	shift
	local _sudo=""
	if $(path_need_sudo $_path); then
		_sudo="sudo "
	fi
	$PRINT && printf "\t${_sudo}touch \"$_path\"\n"
	! $WRITE || $_sudo touch "$_path"; check_error $?
	$PRINT && printf "\t${_sudo}printf \"$@\" > \"$_path\"\n"
	! $WRITE || $_sudo printf "$@" > "$_path"; check_error $?
	return 0
}

_link_file() {
	local _sudo=""
	if $(path_need_sudo $1) || $(path_need_sudo $2); then
		_sudo="sudo "
	fi
	$PRINT && printf "\t${_sudo}ln -s \"$1\" \"$2\"\n"
	! $WRITE || $_sudo ln -s "$1" "$2"; check_error $?
	return 0
}

link_file() {
	[ ${#@} == 3 ] && true; check_error $? nargs
	local name="$(basename $1)"
	local src="$(path_set_pre $1 $DOTFILES)"
	local dst="$(path_set_pre $2 $HOME)"
	local desc="$3"
	local desc_long="Replacing $3: "
	local desc_len="${#desc_long}"
	local desc_long="${BLUE}$desc_long${RESET}\n"
	local dirs="$(dirname "$dst")"
	local srcs="$(dirname "$src")"

	printf "$desc_long"

	path_create "$dirs"
	path_create "$srcs"
	rm_file "$dst"
	_link_file "$src" "$dst"
	# print_at 5 $desc_len "${GREEN}OK${RESET}"
}
