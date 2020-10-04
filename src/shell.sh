#!/usr/bin/bash

# Shell dotfiles
dotfiles_shell() {
	local -a util_arr=(
		.util
		.util.d
	)
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

	print_section "Util"
	for util_arr in ${util_arr[@]}; do
		link_file $DOTFILES_SHELL/$util_arr $util_arr "$util_arr"
	done

	print_section "Profile"
	for profile_arr in ${profile_arr[@]}; do
		link_file $DOTFILES_SHELL/$profile_arr $profile_arr "$profile_arr"
	done

	print_section "Bash"
	for bash_arr in ${bash_arr[@]}; do
		link_file $DOTFILES_SHELL/$bash_arr $bash_arr "$bash_arr"
	done

	. $DOTFILES_SHELL/.util; check_error $?
	. $DOTFILES_SHELL/.profile; check_error $?
	. $DOTFILES_SHELL/.bashrc; check_error $?
}

. $DOTFILES_SRC/init.sh dotfiles_shell
