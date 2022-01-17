#!/usr/bin/bash

sudo_activate() {
	sudo -n true 2> /dev/null
	if [ $? -ne 0 ]; then
		printf "\tInstall requires sudo:\n\t" >&2
		sudo -v
	fi
}

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
	local _err="0"
	if $(path_is_abs $1) && ! [[ "$1" == $HOME* ]]; then
		if $SUDO; then
			sudo_activate
			sudo -n true 2> /dev/null
			_err="$?"
		fi
		printf "true"
	else
		printf "false"
	fi
	return $_err
}

eval_cmd() {
	local _cmd="$1"
	shift
	local _args="$@"

	$PRINT && printf "\t$_cmd $_args\n"
	! $WRITE || $_cmd $_args; check_error $?
}

sudo_set() {
	local _sudo=""
	tmp="$($1 "$2")"
	local _err="$?"
	if $tmp; then
		[ $_err -ne 0 ] && return 1
		! $SUDO && return 1
		_sudo="sudo "
	fi
	printf "$_sudo"
}

path_create() {
	tmp="$(sudo_set path_need_sudo "$1")"
	[ $? -ne 0 ] && return 1

	$PRINT && printf "\t${tmp}mkdir -p \"$1\"\n"
	! $WRITE || $tmp mkdir -p "$1"; check_error $?
}

rm_file() {
	tmp="$(sudo_set path_need_sudo "$1")"
	[ $? -ne 0 ] && return 1

	$PRINT && printf "\t${tmp}rm -f \"$1\"\n"
	! $WRITE || $tmp rm -f "$1"; check_error $?
}

create_file() {
	tmp="$(sudo_set path_need_sudo "$1")"
	[ $? -ne 0 ] && return 1

	local _path="$1"
	shift
	$PRINT && printf "\t${tmp}touch \"$_path\"\n"
	! $WRITE || $tmp touch "$_path"; check_error $?
	$PRINT && printf "\t${tmp}printf \"$@\" > \"$_path\"\n"
	! $WRITE || $tmp printf "$@" > "$_path"; check_error $?
}

_link_file() {
	tmp1="$(sudo_set path_need_sudo "$1")"
	[ $? -ne 0 ] && return 1
	tmp2="$(sudo_set path_need_sudo "$2")"
	[ $? -ne 0 ] && return 1
	[ "$tmp2" == "sudo " ] && tmp1=$tmp2

	$PRINT && printf "\t${tmp1}ln -s \"$1\" \"$2\"\n"
	! $WRITE || $tmp1 ln -s "$1" "$2"; check_error $?
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

	path_create "$dirs"; [ $? -ne 0 ] && return
	path_create "$srcs"; [ $? -ne 0 ] && return
	rm_file "$dst"; [ $? -ne 0 ] && return
	_link_file "$src" "$dst"
}
