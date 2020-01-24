#!/usr/bin/env bash
screens_info="$(xrandr --verbose | grep -A 1 " connected" | grep -v "\-\-" | awk '{print $1,$2}' | xargs -n 4)"
main_name="eDP"
main=()
extended=()

while IFS= read -r line; do
	name="$(echo "$line" | awk '{print $1}')"
	id="$(echo "$line" | awk '{print $4}')"
	is_main="$(echo "$name" | grep $main_name)"
	if [ ! -z "$is_main" ]; then
		main+=("$name")
		main+=("$id")
	else
		extended+=("$name")
		extended+=("$id")
	fi
done <<< "$screens_info"

if [ "${extended[1]}" == "0x45" ]; then
	autorandr -l office
	nitrogen --restore
elif [ "${extended[1]}" == "25600x1440" ]; then
	autorandr -l home
	nitrogen --restore
else
	autorandr -l mobile
fi
