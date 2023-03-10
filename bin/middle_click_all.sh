#!/bin/bash

# Xdotool click in the middle of all active screens
DEBUG=false

# Get the number of screens
get_screens() {
	SCREENS=$(($(xrandr | grep " connected" | wc -l)))
	$DEBUG && echo "Screens: $((SCREENS))"
}

# Get the resolution of each screen
get_res() {
	for ((i = 0; i < $SCREENS; i++)); do
		n=$((i + 1))

		res="$(xrandr | grep -Po " connected[^\d]*\K\d+x\d+\+\d+\+\d+" | sed -n "$n p")"
		w="$(echo $res | grep -Po "^\d+")"
		h="$(echo $res | grep -Po "^\d+x\K\d+")"
		x="$(echo $res | grep -Po "^\d+x\d+\+\K\d+")"
		y="$(echo $res | grep -Po "^\d+x\d+\+\d+\+\K\d+")"

		mx="$(echo "$x+$w/2" | bc)"
		my="$(echo "$y+$h/2" | bc)"
		POS[$i]="$mx $my"

		$DEBUG && echo -e "Screen $i: Pos: ${x}x$y\tSize: $w,$h, Middle: ${pos[$i]}"
	done
}

# Click in the middle of each screen
click_middle() {
	for ((i = 0; i < $SCREENS; i++)); do
		echo "Clicking screen $i"

		# Perform the click
		pos="${POS[$i]}"
		$DEBUG && echo xdotool mousemove $pos click 1
		xdotool mousemove $pos click 1 2>/dev/null

		$DEBUG && [[ $i -lt $((SCREENS)) ]] && echo
	done
	$DEBUG && echo
}

# Get current mouse position
save_current() {
	cur_xy="$(xdotool getmouselocation 2>&1 | tail -n1 | grep -Po "^x:\d+ y:\d+")"
	cur_x="$(echo $cur_xy | grep -Po "x:\K\d+")"
	cur_y="$(echo $cur_xy | grep -Po "y:\K\d+")"
}

# Restore mouse position
restore_current() {
	# xdotool mousemove ${cur}
	xdotool mousemove $cur_x $cur_y 2>/dev/null
}

main() {
	save_current
	get_screens
	get_res
	click_middle
	restore_current
}
main
