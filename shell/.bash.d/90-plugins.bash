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
		_file="$(fzf -m --height 60%)" \
			&& history -s "vim $_file" \
			&& vim $_file
	}

	fzf_open_multi() {
		_files="$(fzf -m --height 60%)" \
			&& history -s "vim -p $(xargs <<< "$_files")" \
			&& vim -p $_files
	}

	fzf_upwards_pwd() {
		paths="$(pwd_list)"
		len="$(($(wc -l <<< "$paths") + 2))"
		basenames=""
		i=2
		while IFS= read -r line; do
			num_dots="$(($len - $i + 1))"
			num_spaces="$(($i - 1))"
			dots="$(printf '.%.0s' $(seq 1 $num_dots))"
			spaces="$(printf ' %.0s' $(seq 1 $num_spaces))"
			basenames="$basenames\n$dots$spaces$(basename "$line")"
			((i++))
		done <<< "$paths"
		basenames="$(echo -e "$basenames" | tail -n +2 | tac)"
		basenames_numbers="$(echo -ne "$basenames" | cat -n)"
		match="$(echo -e "$basenames" | fzf)"
		number="$(echo -e "$basenames_numbers" | grep -e "$match$")"
		echo $number
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
