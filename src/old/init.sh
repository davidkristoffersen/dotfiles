#!/usr/bin/bash

dotfiles_init() {
	pwd_org="$(pwd)"
	local _cur="$(dirname "${BASH_SOURCE[0]}")"
	cd "$_cur/.."
	export DOTFILES="$(pwd)"
	. $DOTFILES/src/meta.sh
	sudo -K
}

dotfiles_meta_init() {
	local _src="$DOTFILES_SRC/meta.sh"
	local _dst="$HOME/.dotfiles_meta.sh"

	local _out="export DOTFILES=\"$DOTFILES\""
	local _pre="$(cat $_src | head -n 2)"
	local _post="$(cat $_src | tail -n +3)"
	_out="$_pre\n\n$_out\n\n$_post"

	printf "$_out" > $_dst
}

dotfiles_script() {
	if [ ! -z "$1" ]; then
		if [ "$(type -t $1)" == "function" ]; then
			eval "$1"
			local _err=$?
		else
			local _err=1
		fi
		. $DOTFILES_SRC/fini.sh
		return $_err
	fi
}

dotfiles_init_main() {
	if [ ! -z "$2"]; then
		dotfiles_script $@
		return $?
	fi

	dotfiles_init
	dotfiles_meta_init
	. $DOTFILES_SRC/config.sh
	. $DOTFILES_SRC/print.sh
	. $DOTFILES_SRC/util.sh
	dotfiles_script $@
}
dotfiles_init_main $@
