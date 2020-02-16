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
	printf "$RESET$FAINT"
	printf "#%.0s" $(seq 1 $((${#1} + 4)))
	printf "\n$FAINT# $RESET$BYELLOW$1$RESET $FAINT#\n"
	printf "#%.0s" $(seq 1 $((${#1} + 4)))
	printf "$RESET\n"
}

link_section() {
	printf "\n$FAINT# $RESET$BCYAN$1$RESET\n"
}

create_path() {
	printf "\tmkdir -p \"$1\"\n"; check_error $?
	mkdir -p "$1"; check_error $?
}

rm_file() {
	printf "\trm -f \"$1\"\n"; check_error $?
	rm -f "$1"; check_error $?
}

_link_file() {
	printf "\tln -s \"$1\" \"$2\"\n"; check_error $?
	ln -s "$1" "$2"; check_error $?
}

path_set_pre() {
	case $1 in
		/*) printf "$1" ;;
		*) printf "$2/$1" ;;
	esac
}

link_file() {
	[ ${#@} == 3 ] && true; check_error $? nargs
	local name="$(basename $1)"
	local src="$(path_set_pre $1 $DOTFILES)"
	local dst="$(path_set_pre $2 $HOME)"
	local desc="$3"
	local desc_long="Replacing $3:\t"
	local desc_len="${#desc_long}"
	local desc_long="${BLUE}$desc_long${RESET}\n"
	local dirs="$(dirname "$dst")"

	printf "$desc_long"

	create_path "$dirs"
	rm_file "$dst"
	_link_file "$src" "$dst"

	print_at 3 $OK_POS "${GREEN}OK${RESET}"
}

# Shell dotfiles
link_bash() {
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
		link_file $profile_arr $profile_arr "$profile_arr"
	done

	link_section "Bash"
	for bash_arr in ${bash_arr[@]}; do
		link_file $bash_arr $bash_arr "$bash_arr"
	done

	. .profile; check_error $?
	. .bashrc; check_error $?
}

# $HOME dotfiles
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

update_submodules() {
	echo
	git submodulepull; check_error $?
}

link_bin() {
	echo
	local _scripts="$(ls -A1 bin)"
	for script in $_scripts; do
		link_file "bin/$script" "$XDG_SCRIPT_HOME/$script" "$script"
	done
}

main() {
	dotfiles_init
	dotfiles_conf_init

	link_header "Shell dotfiles"
	link_bash
	echo
	link_header "\$HOME dotfiles"
	link_home
	echo
	link_header "Update submodules"
	update_submodules
	echo
	link_header "Shell scripts"
	link_bin

	dotfiles_fini
}
main
