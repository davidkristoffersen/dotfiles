#!/usr/bin/env bash

dotfiles_init_main() {
	local _child="$(basename ${BASH_SOURCE[2]})"
	local _parent="$(basename $0)"
	if ! [ "$_child" == "$_parent" ]; then
		return 1
	fi
}

dotfiles_init() {
	pwd_org="$(pwd)"
	local _cur="$(dirname "${BASH_SOURCE[0]}")"
	cd "$_cur/.."
	export DOTFILES="$(pwd)"
	export DOTFILES_SRC="$DOTFILES/src"
	. $DOTFILES_SRC/meta.sh

	WRITE=true
	SUBMODULE=true

	OK_POS="$(($(tput cols) - 4))"

	printf "Install requires sudo: "
	echo
	sudo true
}

dotfiles_conf_init() {
	local _src="$DOTFILES_SRC/meta.sh"
	local _dst="$HOME/.dotfiles_meta.sh"

	local _out="export DOTFILES=\"$DOTFILES\""
	local _pre="$(cat $_src | head -n 2)"
	local _post="$(cat $_src | tail -n +3)"
	_out="$_pre\n\n$_out\n\n$_post"

	printf "$_out" > $_dst
}

dotfiles_init_main
[ $? -ne 0 ] && return 1
dotfiles_init
dotfiles_conf_init
. $DOTFILES_SRC/print.sh
. $DOTFILES_SRC/util.sh
