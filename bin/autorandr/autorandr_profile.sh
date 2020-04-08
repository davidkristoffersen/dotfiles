#!/usr/bin/env bash

autorandr_config="$HOME/.config/autorandr"
test -d "$autorandr_config"
check_error $? "Autorandr config directory does not exist: $autorandr_config"

fingerprint="$(autorandr --fingerprint)"
profiles="$(ls -A1 $autorandr_config)"

for profile in $profiles; do
	setup="${autorandr_config}/${profile}/setup"
	test -f "$setup"
	check_error $? "Config setup does not exist: $setup"
	setup="$(cat $setup)"

	if [ "$setup" == "$fingerprint" ]; then
		echo $profile
		exit
	fi
done
