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

	fzf_update() { $DOTFILES_HOME/.vim/pack/general/opt/fzf/install --bin; }
}

_fzf
unset -f _fzf

_vim-prettier() {
	vim-prettier_update() {
		cd $DOTFILES_HOME/.vim/pack/general/opt/vim-prettier
		yarn
		cd - > /dev/null
	}
}

_vim-prettier
unset -f _vim-prettier
