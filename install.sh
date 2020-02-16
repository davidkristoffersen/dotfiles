#!/usr/bin/env bash

dotfiles_init() {
	pwd_org="$(pwd)"
	local cur="$(dirname "${BASH_SOURCE[0]}")"
	cd "$cur"
	export DOTFILES="$(pwd)"
	OK_POS="$(($(tput cols) - 4))"
}

dotfiles_conf_init() {
	local path="$HOME/.dotfiles.sh"
	echo "#!/usr/bin/env bash" > $path
	echo >> $path
	echo "export DOTFILES=\"$DOTFILES\"" >> $path
}

dotfiles_fini() {
	cd "$pwd_org"
}

link_header() {
	printf "$FAINT"
	printf "#%.0s" $(seq 1 $((${#1} + 4)))
	printf "\n$FAINT# $RESET$BYELLOW$1$RESET $FAINT#\n"
	printf "#%.0s" $(seq 1 $((${#1} + 4)))
	printf "$RESET\n"
}

link_section() {
	printf "\n$FAINT# $RESET$BCYAN$1$RESET\n"
}

link_file() {
	[ ${#@} == 3 ] && true; check_error $? nargs
	local name="$(basename $1)"
	local src="$DOTFILES/$1"
	local dst="$HOME/$2"
	local desc="$3"
	local desc_long="Replacing $3:\t"
	local desc_len="${#desc_long}"
	local desc_long="${BLUE}$desc_long${RESET}\n"
	local dirs="$(dirname "$dst")"

	printf "$desc_long"

	printf "\tmkdir -p \"$dirs\"\n"; check_error $?
	mkdir -p "$dirs"; check_error $?

	printf "\trm -f \"$dst\"\n"; check_error $?
	rm -f "$dst"; check_error $?

	printf "\tln -s \"$src\" \"$dst\"\n"; check_error $?
	ln -s "$src" "$dst"; check_error $?

	print_at 3 $OK_POS "${GREEN}OK${RESET}"
}

# Bashrc and profile
link_bash() {
	local -a profile_arr=(
		.bash_profile
		.profile
		.profile.d
	)
	local -a bash_arr=(
		.bashrc
		.bash.d
		.bash_logout
	)

	link_section "Profile"
	for profile_arr in ${profile_arr[@]}; do
		link_file $profile_arr $profile_arr "$profile_arr"
	done

	link_section "Bash"
	for bash_arr in ${bash_arr[@]}; do
		link_file $bash_arr $bash_arr "$bash_arr"
	done
}

# Dot files in $HOME
link_home() {
	link_section "Git"
	# Config
	link_file .gitconfig .gitconfig ".gitconfig"

	link_section "Session management"
	# I3
	link_file i3.config .config/i3/config "i3 config"

	# Rofi
	link_file rofi.rasi .config/rofi/config.rasi "rofi config"

	# Terminator
	link_file terminator.ini .config/terminator/config "terminator config"

	# Tmux
	link_file .tmux.conf .tmux.conf ".tmux.conf"

	link_section "Editor"
	# Vimrc files
	link_file .vim .vim "vim dir config"
	link_file .vim/.vimrc .vimrc "vim config"

	# Latex
	link_file template.latex .config/latex/template.latex "Latex template"

	link_section "CLI programs"
	# SQLite
	link_file .sqliterc.sql .sqliterc "SQLite config"

	# Htop
	link_file htoprc .config/htop/htoprc "htop config"

	link_section "GUI programs"
	# GIMP
	link_file gimprc .gimp-2.0/gimprc "GIMP config"

	# Gitk
	link_file gitk .config/git/gitk "gitk config"
}

main() {
	dotfiles_init
	dotfiles_conf_init

	link_header "Shell dotfiles"
	link_bash
	echo
	link_header "\$HOME dotfiles"
	link_home

	dotfiles_fini
}
main
