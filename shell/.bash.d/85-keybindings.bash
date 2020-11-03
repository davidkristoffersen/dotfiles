#!/usr/bin/bash

if $SHELL_INTERACTIVE; then
	# Fuzzy cd upwards cwd
	bind -m vi-command '"\eC": "i fzf_upwards_pwd\C-m\e"'
	bind -m vi-insert '"\eC": " fzf_upwards_pwd\C-m"'
	# Fuzzy open one file in vim
	bind -m vi-command '"\C-f": "i fzf_open_single\C-m\e"'
	bind -m vi-insert '"\C-f": " fzf_open_single\C-m"'
	# Fuzzy open multiple files in vim
	bind -m vi-command '"\C-n": "i fzf_open_multi\C-m\e"'
	bind -m vi-insert '"\C-n": " fzf_open_multi\C-m"'
fi
