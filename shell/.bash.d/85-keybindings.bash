#!/usr/bin/bash

if $SHELL_INTERACTIVE; then
	# Fuzzy open one file in vim
	bind -m vi-command '"\C-f": "_file=\"$(fzf --height 60%)\" && vim $_file\C-m"'
	bind -m vi-insert '"\C-f": "_file=\"$(fzf --height 60%)\" && vim $_file\C-m"'
	# Fuzzy open one multiple files in vim
	bind -m vi-command '"\C-n": "_files=\"$(fzf -m --height 60%)\" && vim -p $_files\C-m"'
	bind -m vi-insert '"\C-n": "_files=\"$(fzf -m --height 60%)\" && vim -p $_files\C-m"'
fi
