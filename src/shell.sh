#!/usr/bin/env bash

# Shell dotfiles
link_shell() {
	local -a profile_arr=(
		.bash_profile
		.profile
		.profile.d
	)
	local -a bash_arr=(
		.bashrc
		.bash.d
		.bash_completion.d
		.bash_logout
	)

	link_section "Profile"
	for profile_arr in ${profile_arr[@]}; do
		link_file $DOTFILES_SHELL/$profile_arr $profile_arr "$profile_arr"
	done

	link_section "Bash"
	for bash_arr in ${bash_arr[@]}; do
		link_file $DOTFILES_SHELL/$bash_arr $bash_arr "$bash_arr"
	done

	. $DOTFILES_SHELL/.profile; check_error $?
	. $DOTFILES_SHELL/.bashrc; check_error $?
}

. $DOTFILES_SRC/init.sh
[ $? -ne 0 ] && return 1
link_shell
. $DOTFILES_SRC/fini.sh
