#!/usr/bin/bash

dotfiles_share() {
	echo

	# Bash metadata
	link_file "$DOTFILES_SHARE/bash-metadata" "$XDG_DATA_HOME/bash-metadata" "bash metadata"

	# Backgrounds
	link_file "$DOTFILES_SHARE/backgrounds" "$XDG_DATA_HOME/backgrounds" "backgrounds"

	# Rofi themes
	link_file "$DOTFILES_SHARE/rofi" "$XDG_DATA_HOME/rofi" "rofi themes"
}

. $DOTFILES_SRC/init.sh dotfiles_share
