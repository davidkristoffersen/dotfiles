#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

SESSION="$1"

# Merge in defaults and keymaps
_merge() {
	if [ -f $sysresources ]; then
		xrdb -merge $sysresources
	fi

	if [ -f $sysmodmap ]; then
		xmodmap $sysmodmap
	fi

	if [ -f "$userresources" ]; then
		xrdb -merge "$userresources"
	fi

	if [ -f "$usermodmap" ]; then
		xmodmap "$usermodmap"
	fi
}

# Start up programs
_progs() {
	if [ -d /etc/X11/xinit/xinitrc.d ]; then
		for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
			[ -x "$f" ] && . "$f"
		done
		unset f
	fi
}

# Get window manager or desktop environment to start
_session() {
	local dbus_args=(--sh-syntax --exit-with-session)
	awesome_args=("")
	i3_args=("--shmlog-size" "0")

	case "$1" in
	awesome) dbus_args+=(awesome ${awesome_args[*]}) ;;
	i3 | i3wm) dbus_args+=(i3 ${i3_args[*]}) ;;
	kde) dbus_args+=(startkde) ;;
	xfce) dbus_args+=(xfce4-session) ;;
	*) dbus_args+=("$1") ;;
	esac

	echo "dbus-launch ${dbus_args[*]}"
}

# Set keyboard layout
_layout() {
	setxkbmap no -variant nodeadkeys
}

_merge
_progs
_layout
exec $(_session "$SESSION")

unset -f _merge _progs _session _layout
