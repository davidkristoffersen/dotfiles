#!/usr/bin/env bash

. $HOME/.dotfiles.sh

for bash_file in $(ls -A1 $DOTFILES/.bash.d | sort); do
	if [ "$bash_file" == ".gitignore" ]; then
		continue
	elif [[ $bash_file == 00-*.bash ]]; then
		. $DOTFILES/.bash.d/$bash_file
		continue
	fi

	. $DOTFILES/.bash.d/$bash_file; check_error 0
done
