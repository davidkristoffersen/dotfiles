#!/usr/bin/env bash

autorandr_config="$HOME/.config/autorandr"
if [ ! -d "$autorandr_config" ]; then
	echo -e "Autorandr config directory does not exist: $autorandr_config"
	exit
fi

function get_edid() {
	local edid_line="$(($(xrandr --props | nl | grep -A 1 "$1 connected" | grep -v "\-\-" | grep "EDID" | awk '{print $1}') + 1))"
	edid=""

	while IFS= read -r line; do
		if [ "${line:0:2}" != $'\t\t' ]; then
			break
		fi
		printf -v edid "$edid\n${line:2:$((${#line}-2))}"
	done <<< "$(xrandr --props | tail +$edid_line)"
	edid="$(echo "$edid" | tail +2)"
}

main_name="eDP"
screens_info="$(xrandr --props | grep -A 1 " connected" | grep -v "\-\-" | awk '{print $1,$2}' | xargs -n 3)"

while IFS= read -r line; do
	name="$(echo "$line" | awk '{print $1}')"
	has_edid="$( [ "$(echo "$line" | awk '{print $3}')" == "EDID:" ] )"
	is_main="$(echo "$name" | grep $main_name)"

	if ! $has_edid; then
		continue
	fi

	get_edid $name
	if [ -z "$is_main" ]; then
		break
	fi
done <<< "$screens_info"

profiles="$(ls -A1 $autorandr_config)"
for profile in $profiles; do
	config_edid="${autorandr_config}/${profile}/edid.hex"
	if [ ! -f "$config_edid" ]; then
		echo "Config edid.hex does not exist: $config_edid"
		exit
	fi
	config_edid="$(cat $config_edid)"

	if [ "$edid" == "$config_edid" ]; then
		echo $profile
		exit
	fi
done
