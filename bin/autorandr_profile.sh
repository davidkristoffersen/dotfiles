#!/usr/bin/env bash

autorandr_config="$HOME/.config/autorandr"
test -d "$autorandr_config"
check_error $? "Autorandr config directory does not exist: $autorandr_config"

main_port="eDP"
port="$(autorandr --fingerprint | awk '{ print $1 }' | grep -ve "^$main_port")"
if [ -z $port ]; then
	port="$(autorandr --fingerprint | awk '{ print $1 }')"
fi
edid="$(autorandr_edid.sh $port)"

profiles="$(ls -A1 $autorandr_config)"
for profile in $profiles; do
	config_edid="${autorandr_config}/${profile}/edid.hex"
	test -f "$config_edid"
	check_error $? "Config edid.hex does not exist: $config_edid"

	config_edid="$(cat $config_edid)"

	if [ "$edid" == "$config_edid" ]; then
		echo $profile
		exit
	fi
done
