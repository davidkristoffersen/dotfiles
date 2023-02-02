#!/usr/bin/bash

_bashrc() {
	. $HOME/.dotfiles_meta.sh
	[ $? -ne 0 ] && return
	local d_path="$DOTFILES_SHELL/.bash.d"

	for bash_file in $(ls -A1 "$d_path" | sort); do
		local file_path="$d_path/$bash_file"

		if [ "$bash_file" == ".gitignore" ] || [ -d "$file_path" ]; then
			continue
		fi

		. $file_path
		check_error 0
	done

	export SHELL_BASHRC=true
}

_bashrc
unset -f _bashrc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
