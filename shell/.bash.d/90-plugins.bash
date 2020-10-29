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

	fzf_update() {
		$DOTFILES_HOME/.vim/pack/general/opt/fzf/install --bin
	}

	fzf_open_single() {
		_file="$(fzf -m --height 40%)" \
			&& history -s "vim $_file" \
			&& vim $_file
	}

	fzf_open_multi() {
		_files="$(fzf -m --height 40%)" \
			&& history -s "vim -p $(xargs <<< "$_files")" \
			&& vim -p $_files
	}

	fzf_upwards_pwd() {
		full_paths="$(pwd_full_list | tac)"
		dot_paths="$(pwd_dot_list | tac)"
		dot_nums="$(echo -ne "$dot_paths" | cat -n)"
		match="$(echo -e "$dot_paths" | fzf -m --height 40%)"
		if [ -z "$match" ]; then
			return
		fi
		number="$(echo -e "$dot_nums" | grep -e "$match$" | xargs | grep -oe "^[0-9]*")"
		path="$(echo "$full_paths" | head -n $number | tail -n +$number)"
		cd "$path"
	}
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
