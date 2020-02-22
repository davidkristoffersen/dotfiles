#!/usr/bin/env bash

autorandr_config="$HOME/.config/autorandr"
if [ ! -d "$autorandr_config" ]; then
	echo -e "Autorandr config directory does not exist: $autorandr_config"
	exit
fi

main_name="eDP"
screens_info="$(xrandr --props | grep -A 1 " connected" | grep -v "\-\-" | awk '{print $1,$2}' | xargs -n 3)"

while IFS= read -r line; do
	name="$(echo "$line" | awk '{print $1}')"
	has_edid="$( [ "$(echo "$line" | awk '{print $3}')" == "EDID:" ] )"
	is_main="$(echo "$name" | grep $main_name)"

	if ! $has_edid; then
		continue
	fi

	edid="$(autorandr_edid.sh $name)"
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
