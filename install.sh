#!/usr/bin/env bash

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
	printf "\trm -rf \"$dst\"\n"; check_error $?
	printf "\tln -s \"$src\" \"$dst\"\n"; check_error $?
	print_at 3 $OK_POS "${GREEN}OK${RESET}"
}

OK_POS="$(($(tput cols) - 4))"
export DOTFILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

# Dot files in $HOME
home_dot_files=(.bash_profile
				.profile
				.profile.d
				.bashrc
				.bashrc.d
				.bash_logout
				.gitconfig
				.tmux.conf
)

for home_dot_file in ${home_dot_files[@]}; do
	link_file $home_dot_file $home_dot_file "$home_dot_file"
done
echo

# Session management
# I3
link_file i3.config .config/i3/config "i3 config"

# Rofi
link_file rofi.rasi .config/rofi/config.rasi "rofi config"

# Terminator
link_file terminator.ini .config/config/terminator.ini "terminator config"
echo

# Editor
# Vimrc files
link_file .vim .vim "vim dir config"
link_file .vimrc .vim/.vimrc "vim config"

# Latex
link_file template.latex .config/latex/template.latex "Latex template"
echo

# CLI programs
# SQLite
link_file .sqliterc.sql .sqliterc "SQLite config"

# Htop
link_file htoprc .config/htop/htoprc "htop config"
echo

# GUI programs
# GIMP
link_file gimprc .gimp-2.0/gimprc "GIMP config"

# Gitk
link_file gitk .config/git/gitk "gitk config"
echo
