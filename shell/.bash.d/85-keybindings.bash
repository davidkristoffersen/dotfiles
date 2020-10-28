#!/usr/bin/bash

if $SHELL_INTERACTIVE; then
	_fzf_open_single='_file="$(fzf -m --height 60%)" && history -s "vim $_file" && vim $_file'
	_fzf_open_multi='_files="$(fzf -m --height 60%)" && history -s "vim -p $(xargs <<< "$_files")" && vim -p $_files'

	# Fuzzy open one file in vim
	bind -m vi-command "'\C-f: '$_fzf_open_single\C-m'"
	bind -m vi-insert "'\C-f: '$_fzf_open_single\C-m'"
	# Fuzzy open multiple files in vim
	bind -m vi-command "'\C-n: '$_fzf_open_multi\C-m'"
	bind -m vi-insert "'\C-n: '$_fzf_open_multi\C-m'"
fi
