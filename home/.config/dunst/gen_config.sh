#!/usr/bin/env bash

function script() {
	dst="$DOTFILES/home/.config/dunst/dunst.cfg"

	vars="global _display _text _icons"
	vars+=" _history _advanced experimental"
	vars+=" shortcuts urgencies examples applications"
	dst_code=""
	gen_vars
	format_vars > $dst
}

function format_vars() {
	local _tab=""
	for var in $vars; do
		[ "${var:0:1}" == "_" ] && _tab="\t" || _tab=""
		read -r -d '' tmp << EOF
$_tab#
$_tab# $(echo ${var^^} | tr '_' ' ')
$_tab#

$(eval "echo -e \"\$_tab\$$var\"")
\n
EOF
		dst_code+="$tmp"
	done

	echo -e "$dst_code" | head -n -2
}

function gen_vars() {
	# ```cfg
	read -r -d '' global << EOF
[global]
EOF

	read -r -d '' _display << EOF
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
EOF

	read -r -d '' _text << EOF
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
	show_age_threshold = 30
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
EOF

	read -r -d '' _icons << EOF
	# Types: left, right, off
	icon_position = left
	# Type: Pixels
	max_icon_size = 32
	# Paths to default icons
	icon_path = /usr/share/icons/Papirus/16x16/mimetypes/:/usr/share/icons/Papirus/48x48/status/:/usr/share/icons/Papirus/16x16/devices/:/usr/share/icons/Papirus/48x48/notifications/:/usr/share/icons/Papirus/48x48/emblems/:/tmp/
EOF

	read -r -d '' _history << EOF
	# History notifications, types: yes(sticky), no(timeout)
	sticky_history = yes
	# Num notifications in history
	history_length = 15
EOF

	read -r -d '' _advanced << EOF
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
EOF

	read -r -d '' experimental << EOF
# May not work properly
[experimental]
	# Calculate the dpi to use on a per-monitor basis
	per_monitor_dpi = false
EOF


	read -r -d '' shortcuts << EOF
# Usage: modX+modY+...+key
# Modifiers: ctrl, mod1(alt), mod2, mod3, mod4(Super)
[shortcuts]
	# Close notification
	close = mod4+ctrl+c
	# Close all notifications
	close_all = mod4+ctrl+a
	# Redisplay last message(s)
	history = mod4+ctrl+shift+d
	# Context menu
	context = mod4+ctrl+d
EOF

	read -r -d '' urgencies << EOF
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
EOF

	read -r -d '' examples << EOF
[Example]
	appname = name
	desktop_entry = entry
	summary = summary
	# "" for ignore
	format = "%a\\\\\\\n<b>%s</b>\\\\\\\n%b"
	# new_icon = "path"
	urgency = normal
	timeout = 0
	script = "path"
EOF
	# $```cfg

	local _notify_general="$DOTFILES/bin/notify_general.sh"
	# ```cfg
	read -r -d '' applications << EOF
[General]
	appname = notification
	format = "%s"

[Telegram]
	appname = Telegram Desktop
	script = "$_notify_general"

[Discord]
	appname = discord
	script = "$_notify_general"

[Messenger]
	appname = messengerport
	script = "$_notify_general"

[Chromium]
	appname = Chromium
	script = "$_notify_general"

[Spotify]
	appname = Spotify
	script = "$_notify_general"

[Dunstiny]
	appname = dunstify
	script = "$_notify_general"

[Other]
	appname = *
	# Run script on any unknown name
	script = "$_notify_general"
EOF
	# $```cfg
}

# Run script
script
