#!/usr/bin/env bash

. $HOME/.dotfiles.sh

for profile_file in $(ls -A1 $DOTFILES/.profile.d | sort); do
	if [ "$profile_file" == ".gitignore" ]; then
		continue
	fi

	. $DOTFILES/.profile.d/$profile_file
done
