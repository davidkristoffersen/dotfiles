#!/usr/bin/bash

_fzf() {
	# Use ~~ as the trigger sequence instead of the default **
	# export FZF_COMPLETION_TRIGGER='~~'

	# Default command
	export FZF_DEFAULT_COMMAND="rg --hidden -l '' -g '!.git'"
	export FZF_ALT_C_COMMAND="fdfind --type d --hidden --follow --exclude '.git' ."

	# Completion file
	if [[ $- == *i* ]]; then
		source "$DOTFILES/home/.vim/pack/general/opt/fzf/shell/completion.bash" 2> /dev/null;  check_error $?
	fi

	# Apply key bindings
	source "$DOTFILES/home/.vim/pack/general/opt/fzf/shell/key-bindings.bash"; check_error $?
}

_fzf
unset -f _fzf
