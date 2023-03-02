#!/usr/bin/env bash

b="\x1b[1m" # Bold
r="\x1b[0m" # Reset

echo -e "${b}Unmasking plasma-kwin_x11.service$r"
systemctl unmask plasma-kwin_x11.service --user

dst="$HOME/.config/systemd/user/plasma-i3.service"

if [ -L "$dst" ]; then
	echo -e "$b\nDisabling plasma-i3 service$r"
	systemctl disable plasma-i3 --user
fi
