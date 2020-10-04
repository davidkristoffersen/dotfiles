#!/usr/bin/bash

_profile() {
	. $HOME/.dotfiles_meta.sh
	[ $? -ne 0 ] && return

	for profile_file in $(ls -A1 $DOTFILES_SHELL/.profile.d | sort); do
		if [ "$profile_file" == ".gitignore" ]; then
			continue
		fi

		. $DOTFILES_SHELL/.profile.d/$profile_file
	done

	export SHELL_PROFILE=true
}

_profile
unset -f _profile
