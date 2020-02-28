#!/usr/bin/env bash

dotfiles_private() {
	print_section "Secret dotfiles"
	local _name="dotfiles_secrets"
	# Clone repo
	local _repo="https://github.com/davidkristoffersen/$_name.git"
	eval_cmd "git clone $_repo" "$DOTFILES_PRIVATE/$_name"
	# Link repo
	link_file $DOTFILES_PRIVATE/$_name .$_name "repo"
	# Shell source
	local _secret_body="#!/usr/bin/env bash\n\n"
	_secret_body+=". \$DOTFILES_PRIVATE/$_name/.bashrc"
	create_file $DOTFILES_SHELL/.bash.d/.90-secrets.bash "$_secret_body"
}

. $DOTFILES_SRC/init.sh dotfiles_private
