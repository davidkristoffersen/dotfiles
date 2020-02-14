#!/usr/bin/env bash

export DOTFILES="$HOME/.config/config"

for profile_file in $(ls -A1 $DOTFILES/.profile.d | sort); do
	if [ "$profile_file" == ".gitignore" ]; then
		continue
	fi

	. $DOTFILES/.profile.d/$profile_file
done
