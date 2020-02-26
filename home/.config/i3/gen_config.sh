#!/usr/bin/env bash

function script() {
	dst="$DOTFILES/home/.config/i3/i3.config"

	vars="variables fonts network audio screens"
	vars+=" app_launcher notifications applications navigation"
	vars+=" workspaces appearance config modes"
	vars+=" status_bar autostart_applications"
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
	local m="Mod4"
	local s="Shift"
	local c="Control"
	local a="Mod1"
	local e="exec --no-startup-id"
	local b="bindsym"

	# ```i3config
	read -r -d '' variables << EOF
# Mod1: Alt
# Mod4: Super
EOF

	read -r -d '' fonts << EOF
# Window title font
font pango:monospace 8
EOF

	read -r -d '' network << EOF
# Desktop env independentn system tray gui
$e nm-applet
EOF

	# $```i3config
	refresh_i3status="\$refresh_i3status"
	# ```i3config
	read -r -d '' audio << EOF
# Use pactl to adjust volume in PulseAudio.
set \$refresh_i3status killall -SIGUSR1 i3status

$b XF86AudioRaiseVolume $e pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
$b XF86AudioLowerVolume $e pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
$b XF86AudioMute $e pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
$b XF86AudioMicMute $e pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
EOF

	read -r -d '' screens << EOF
# Output
$e autorandr_helper.sh
$b $m+$s+m $e autorandr_helper.sh

# Lock
$b $m+$s+o $e xlock

# Kill focused window
$b $m+$s+q kill

# Background
$e nitrogen --restore

# Swap active workspaces
$b $m+$s+s $e i3_swap_workspaces.py
EOF

	read -r -d '' app_launcher << EOF
# Rofi
$b $m+d exec rofi -show drun
EOF

	read -r -d '' notifications << EOF
# Kill xfce notification daemon
$e killall -q xfce4-notifyd
# Start dunst notification daemon
$e dunst -config $HOME/.config/dunst/dunstrc
EOF

	read -r -d '' applications << EOF
# Terminal
$b $m+Return exec terminator

# Browser
$b $m+b exec chromium

# Language swap
$b $m+space $e toggle_xkbmap.sh
EOF

	# $```i3config
	local mwto="move workspace to output"
	declare -Ag vim_arrow=([h]="left" [j]="down" [k]="up" [l]="right")
	declare -Ag vim_arrow_mirror=([h]="right" [j]="up" [k]="down" [l]="left")
	nav_type() {
		local _out=""
		if [ "$3" == "vim" ]; then
			for vim in ${!vim_arrow[@]}; do
				_out+="$1+$vim $2 ${vim_arrow[$vim]}\n"
			done
		else
			for vim in ${!vim_arrow[@]}; do
				_out+="$1+${vim_arrow[$vim]^} $2 ${vim_arrow[$vim]}\n"
			done
		fi
		printf "$_out" | column -t
	}
	# ```i3config
	read -r -d '' navigation << EOF
# Change focus
# Tiling / floating
$b $m+Shift+t focus mode_toggle
# Parent container
$b $m+p focus parent
# Child container
$b $m+c focus child

# Vim style
$(nav_type "$b $m" focus vim)
# Arrow style
$(nav_type "$b $m" focus)

# Move container
# Vim style
$(nav_type "$b $m+$s" move vim)
# Arrow style
$(nav_type "$b $m+$s" move)

# Move workspace
# Vim style
$(nav_type "$b $m+$a" "$mwto" vim)
# Arrow style
$(nav_type "$b $m+$a" "$mwto")

# Mouse
# Drag floating style
floating_modifier $m
# Focus
focus_follows_mouse no
# Warping
mouse_warping output

# Split
# Horizontally
$b $m+bar split h
# Vertically
$b $m+minus split v

# Fullscreen focused container
$b $m+f fullscreen toggle

# Layout
$b $m+s layout stacking
$b $m+t layout tabbed
$b $m+e layout toggle split
$b $m+$s+space floating toggle

# Scratchpad / hide
# Make the currently focused window a scratchpad
bindsym $m+$s+minus move scratchpad

# Show the first scratchpad window
bindsym $m+$s+plus scratchpad show
EOF

	# $```i3config
	local wnames="$(seq 0 9)"

	workspace_type() {
		for name in $wnames; do
			echo "$b $1+$name $2 $name"
		done
	}
	workspace_nav() {
		local _out=""
		if [ "$1" == "vim" ]; then
			for name in ${!vim_arrow[@]}; do
				_out+="$b $2+$name"
				_out+=" focus parent; focus parent; focus parent; focus parent"
				_out+="; $3 ${vim_arrow[$name]}"
				_out+="; focus child; focus child; focus child; focus child\n"
			done
		else
			for name in ${!vim_arrow[@]}; do
				_out+="$b $2+${vim_arrow[$name]^}"
				_out+=" focus parent; focus parent; focus parent; focus parent"
				_out+="; $3 ${vim_arrow[$name]}"
				_out+="; focus child; focus child; focus child; focus child\n"
			done
		fi
		printf "$_out" | column -t
	}
	# ```i3config
	read -r -d '' workspaces << EOF
# Switch to workspace
$(workspace_type $m "workspace number")

# Move focused container to workspace
$(workspace_type $m+$s "move container to workspace number")

# Rename focused workspace
$(workspace_type $m+$a "rename workspace to")

# Focus directional workspace
# Vim style
$(workspace_nav vim $m+$c "focus")
# Arrow style
$(workspace_nav arrow $m+$c "focus")

# Focus next/prev workspace on current monitor
$b $m+$c+n workspace next_on_output
$b $m+$c+p workspace prev_on_output
$b $m+$c+Tab workspace next_on_output
$b $m+$c+$s+Tab workspace prev_on_output

# Focus next/prev workspace on all monitors
$b $m+$c+$a+n workspace next
$b $m+$c+$a+p workspace prev
$b $m+$c+$a+Tab workspace next_on_output
$b $m+$c+$a+$s+Tab workspace prev_on_output
EOF

	read -r -d '' appearance << EOF
# Gaps size
gaps inner 20
gaps outer 0

default_border pixel 2

# class                 border  backgr. text    indicator child_border
client.focused       	#aaaaaa #aaaaaa #000000 #aaaaaa   #aaaaaa
client.focused_inactive #555555 #555555 #ffffff #555555   #555555
client.unfocused      	#000000 #000000 #888888 #000000   #000000
client.urgent           #2f343a #900000 #ffffff #900000   #900000
client.placeholder      #000000 #0c0c0c #ffffff #000000   #0c0c0c

client.background       #ffffff

# App specific
# for_window [class="^Chromium$" title=" - Chromium$"] border 1
EOF

	read -r -d '' config << EOF
# Reload config
$b $m+$s+c reload

# Restart i3
$b $m+$s+r restart

# Exit i3
$b $m+$s+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"
EOF
	# $```i3config

	resize_type() {
		local grow="resize grow"
		local shrink="resize shrink"
		local size="10 px or 10 ppt"
		local _out=""

		if [ "$1" == "vim" ]; then
			for vim in ${!vim_arrow[@]}; do
				_out+="\t$b $vim $grow ${vim_arrow[$vim]} $size; "
				_out+="$shrink ${vim_arrow_mirror[$vim]} $size\n"
			done
		else
			for vim in ${!vim_arrow[@]}; do
				_out+="\t$b ${vim_arrow[$vim]^} $grow ${vim_arrow[$vim]} $size; "
				_out+="$shrink ${vim_arrow_mirror[$vim]} $size\n"
			done
		fi

		printf "$_out"
	}
	# ```i3config
	read -r -d '' modes << EOF
# Resize windows
mode "resize" {
	# Vim style
$(resize_type vim)

	# Arrow style
$(resize_type)

	# Exit mode
	$b Return mode "default"
	$b Escape mode "default"
	$b $m+r mode "default"
}
$b $m+r mode "resize"
EOF

	read -r -d '' status_bar << EOF
# i3bar
bar {
	status_command i3status
}
EOF

	read -r -d '' autostart_applications << EOF
# exec chromium
EOF
# $```i3config
}

# Run script
script
