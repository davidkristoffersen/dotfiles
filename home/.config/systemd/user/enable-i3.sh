#!/usr/bin/env bash

b="\x1b[1m" # Bold
f="\x1b[2m" # Faint
r="\x1b[0m" # Reset

dst="$HOME/.config/systemd/user/plasma-i3.service"
src="$HOME/dotfiles/home/.config/systemd/user/plasma-i3.service"

# If symlink does not exist, create it
if [ ! -L "$dst" ]; then
	echo -e "${b}Create symlink for plasma-i3 service$r"
	echo -e "Created symlink $dst → $src."
	ln -s "$src" "$dst"
fi

echo -e "${b}\nMasking plasma-kwin_x11.service$r"
systemctl mask plasma-kwin_x11.service --user

echo -e "$b\nEnabling plasma-i3 service$r"
systemctl enable plasma-i3 --user
