#!/usr/bin/env bash

function script() {
	set_key config
	set_key dst
	dst="$config/$dst"

	vars="all"
	dst_code=""
	gen_vars
	format_vars > $dst
}

function format_vars() {
	for var in $vars; do
		read -r -d '' tmp << EOF
#
# $(echo ${var^^} | tr '_' ' ')
#

$(eval "echo -e \"\$$var\"")
\n
EOF
		dst_code+="$tmp"
	done

	echo -e "$dst_code" | head -n -2
}

function gen_vars() {
	# ```cfg
	read -r -d '' all << EOF
[global]
	#
	# DISPLAY
	#

	# Which monitor the notifications should be displayed on
	monitor = 0
	# Notification focus, modes: mouse, keyboard, none
	follow = keyboard
	# Window size and pos: WxH(+-)X(+-)Y
	geometry = "400x50-20+20"
	# Show number of hidden messages
	indicate_hidden = yes
	# Shrink window when smaller than the width
	shrink = no
	# Window transparency, range: [0:100]
	# Package dependency: xcompmgr or compiz
	transparency = 40
	# Total height, type: Pixels
	notification_height = 0
	# Type: Pixels
	separator_height = 4
	# Vertical padding, type: Pixels
	padding = 10
	# Type: Pixels
	horizontal_padding = 10
	# Type: Pixels
	frame_width = 4
	# Type: X color
	frame_color = "#aaaaaa"
	# Types: auto, foreground, frame, X color
	separator_color = frame
	# Sort messages by urgency
	sort = Yes
	# Keep message for X second when user is idle
	idle_threshold = 0

	#
	# TEXT
	#

	font = SF Pro Text 12
	# Type: Pixels
	line_height = 10
	# Allow html: <b>, <i>, <s>, <u>
	markup = yes
	plain_text = no
	# Message format
	# %a: appname
	# %s: summary
	# %b: body
	# %i: iconname, w path
	# %I: iconname, w/o path
	# %p: progress in %
	format = "%a $I\\\\\\\n<b>%s</b>\\\\\\\n%b %p"
	# Values: left, center, right
	alignment = left
	# Show age when larger than X seconds, disable: -1
	show_age_threshold = 10
	# Word wrap within message size
	word_wrap = yes
	# Ignore ansi newlines, \\\\\\\n
	ignore_newline = no
	# Merge duplicate messages
	stack_duplicates = yes
	# Show count of duplicate messages
	hide_duplicates_count = no
	# Display types: U(urls), A(actions)
	show_indicators = yes

	#
	# ICONS
	#

	# Types: left, right, off
	icon_position = left
	# Type: Pixels
	max_icon_size = 32
	# Paths to default icons
	icon_path = /usr/share/icons/Papirus/16x16/mimetypes/:/usr/share/icons/Papirus/48x48/status/:/usr/share/icons/Papirus/16x16/devices/:/usr/share/icons/Papirus/48x48/notifications/:/usr/share/icons/Papirus/48x48/emblems/

	#
	# HISTORY
	#

	# History notifications, types: yes(sticky), no(timeout)
	sticky_history = yes
	# Num notifications in history
	history_length = 15

	#
	# MISC / ADVANCED
	#

	# dmenu path
    dmenu = /usr/bin/rofi -dmenu -p dunst:
	# Browser for opening urls in context menu
	browser = /usr/bin/chromium
	# Rule-defined scripts
	always_run_script = true
	# Window title spawned from dunst
	title = Dunst
	# Window class spawned from dunst
	class = Dunst
	# Print a notification on startup
	startup_notification = false

# Experimental features that may not work correctly
[experimental]
	# Calculate the dpi to use on a per-monitor basis
	per_monitor_dpi = false

# Usage: modX+modY+...+key
# Modifiers: ctrl, mod1(alt), mod2, mod3, mod4(Super)
[shortcuts]
	# Close notification
	close = mod4+ctrl+c
	# Close all notifications
	close_all = mod4+ctrl+a
	# Redisplay last message(s)
	history = mod4+ctrl+h
	# Context menu
	context = mod4+ctrl+d

#
# Urgency specific
#

[urgency_low]
	frame_color = "#3B7C87"
	foreground = "#3B7C87"
	background = "#191311"
	timeout = 10
	#icon = /path/to/icon

[urgency_normal]
	frame_color = "#5B8234"
	foreground = "#5B8234"
	background = "#191311"
	timeout = 20
	#icon = /path/to/icon

[urgency_critical]
	frame_color = "#B7472A"
	foreground = "#B7472A"
	background = "#191311"
	timeout = 0
	#icon = /path/to/icon

#
# Application specific
#

[Example]
	appname = name
	desktop_entry = entry
	summary = summary
	format = "%a\\\\\\\n<b>%s</b>\\\\\\\n%b"
	new_icon = "path"
	urgency = normal
	timeout = 0
	script = "path"

[Telegram]
	appname = telegram-desktop
	desktop_entry = telegram-desktop
	format = "T: %a\\\\\\\n<b>%s</b>\\\\\\\n%b"
	new_icon = telegram-desktop_icon
	urgency = critical
	timeout = 0
	script = "$DOTFILES/bin/notify_test.sh"

[Chromium]
	appname = Chromium
	format = ""
	new_icon = ""
	urgency = critical
	script = "$DOTFILES/bin/notify_test.sh"

[Discord]
	appname = discord
	desktop_entry = discord
	summary = "*"
	format = "D: %a\\\\\\\n<b>%s</b>\\\\\\\n%b"
	new_icon = discord_icon
	urgency = critical
	timeout = 0
	script = "$DOTFILES/bin/notify_test.sh"
EOF
	# $```cfg
}

#
# ARGUMENTS
#

function lib_args() {
	# Create initial variables
	help_init "Example title text"

	# Add option
	add_option -s c -m config -v "PATH" -d "$DOTFILES" -i "Dotfiles path"
	add_option -s d -m dst -v "FILE" -d "dunst.cfg" -i "Dest config"
}

#
# TEMPLATE LIBRARY INIT
#

# Source template library
lib="$HOME/.local/lib/bash/run_template_inner.sh"
if [ ! -f "$lib" ]; then echo "Library not found: $lib" >&2; exit; fi
. $lib
# Set argument options
lib_args
# Parse options
parse "$@"
# Run script
script
