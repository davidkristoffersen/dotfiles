#'/usr/bin/bash

if $SHELL_INTERACTIVE; then
	# Fuzzy open one file in vim
	bind -m vi-command '"\C-f": " fzf_open_single\C-m"'
	bind -m vi-insert '"\C-f": " fzf_open_single\C-m"'
	# Fuzzy open multiple files in vim
	bind -m vi-command '"\C-n": " fzf_open_multi\C-m"'
	bind -m vi-insert '"\C-n": " fzf_open_multi\C-m"'
fi
