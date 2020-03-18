#!/usr/bin/env bash

dotfiles_install_init() {
	export DOTFILES="$(cd $(dirname "${BASH_SOURCE[0]}")/..; pwd)"
	. $DOTFILES/src/meta.sh
}

dotfiles_install_args() {
	if [ ! -z "$1" ]; then
		if [ "$1" == "server" ]; then
			. $DOTFILES_SRC/install_server.sh
		else
			echo "Invalid option: $1"
		fi
	else
		. $DOTFILES_SRC/install_all.sh
	fi
}

dotfiles_install_init
dotfiles_install_args $@
