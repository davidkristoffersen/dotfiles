#!/usr/bin/env bash

. $HOME/.dotfiles_meta.sh

for profile_file in $(ls -A1 $DOTFILES_SHELL/.profile.d | sort); do
	if [ "$profile_file" == ".gitignore" ]; then
		continue
	fi

	. $DOTFILES_SHELL/.profile.d/$profile_file
done
