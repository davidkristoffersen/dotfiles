#!/usr/bin/env bash

dotfiles_init() {
	pwd_org="$(pwd)"
	local _cur="$(dirname "${BASH_SOURCE[0]}")"
	cd "$_cur/.."
	export DOTFILES="$(pwd)"
	export DOTFILES_SRC="$DOTFILES/src"

	WRITE=ture
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
	. $_dst
}

dotfiles_fini() {
	cd "$pwd_org"
}

main() {
	dotfiles_init
	dotfiles_conf_init
	. $DOTFILES_SRC/print.sh
	. $DOTFILES_SRC/util.sh
	. $DOTFILES_SRC/shell.sh
	. $DOTFILES_SRC/home.sh
	. $DOTFILES_SRC/bin.sh
	. $DOTFILES_SRC/lib.sh
	. $DOTFILES_SRC/share.sh
	. $DOTFILES_SRC/repo.sh

	link_header "Shell dotfiles"
	link_shell
	echo
	link_header "\$HOME dotfiles"
	link_home
	echo
	link_header "Shell scripts"
	link_bin
	echo
	link_header "Shell libraries"
	link_lib
	echo
	link_header "Shell shared data"
	link_share
	echo
	link_header "Update submodules"
	update_submodules

	dotfiles_fini
}
main
