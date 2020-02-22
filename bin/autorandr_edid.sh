#!/usr/bin/env bash

function get_edid() {
	local edid_line="$(($(xrandr --props | nl | grep -A 1 "$1 connected" | grep -v "\-\-" | grep "EDID" | awk '{print $1}') + 1))"
	local edid=""

	while IFS= read -r line; do
		if [ "${line:0:2}" != $'\t\t' ]; then
			break
		fi
		printf -v edid "$edid\n${line:2:$((${#line}-2))}"
	done <<< "$(xrandr --props | tail +$edid_line)"
	printf "$(echo "$edid" | tail +2)"
}

if ! [[ $1 =~ (eDP-1|DP-1|HDMI-1|HDMI-2) ]]; then
	printf "Usage: $0 [eDP-1|DP-1|HDMI-1|HDMI-2]\n"
	exit
fi

get_edid $1
