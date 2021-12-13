#!/bin/bash

tmpdir="/tmp/"
tmpfile="${tmpdir}head_tmp.png"
overlay_img="$HOME/.local/share/icons/xlock/locked.png"

pre_png="${tmpdir}head_"
post_png=".png"
out="${tmpdir}screen.png"

debug=true

get_autorandr_profile() {
	local profile="$(autorandr_profile.sh)"
	config="$(autorandr_manage.sh -c $profile)"
}

json_config() {
	if [ $# -eq 1 ]; then
		jq -r '.["'$1'"]' <<<"$config"
	elif [ $# -eq 2 ]; then
		jq -r '.["'$1'"]["'$2'"]' <<<"$config"
	elif [ $3 == "list" ]; then
		jq -r '.["'$1'"]['$2']' <<<"$config"
	fi
}

screenshot() {
	num_screens="$(json_config num_screens)"
	for i in $(seq 0 $((num_screens - 1))); do
		local screen="$(json_config screens $i list)"
		local out="/tmp/head_$i.png"

		local w="$(json_config $screen w)"
		local h="$(json_config $screen h)"
		local x="$(json_config $screen x)"
		local y="$(json_config $screen y)"
		$debug && echo -e "$timeit_tab$out:\t${w}x${h}+${x}+${y}"

		scrot -o -a ${x},${y},${w},${h} $out
	done
}

modify_par() {
	. $(which env_parallel.bash)
	echo $(seq 0 $((num_screens - 1))) | tr " " "\n" | env_parallel timeit modify
}

modify_seq() {
	for i in $(seq 0 $((num_screens - 1))); do
		timeit modify $i
	done
}

modify() {
	blurred $1
	pixelize $1
	overlay $1
}

blurred() {
	local _png=$pre_png$1$post_png
	gm convert $_png -scale 10% -blur 0x2.5 -resize 1000% $_png
}

pixelize() {
	local _png=$pre_png$1$post_png
	pixelize.py $_png $_png 15
}

overlay() {
	local _file="$pre_png$1$post_png"
	if [[ -f $overlay_img ]]; then
		gm composite -matte -gravity center $overlay_img $_file $_file
	fi
}

combine() {
	if [ "$num_screens" == 1 ]; then
		mv ${pre_png}0$post_png $out
		return
	fi

	width="$(json_config max_w)"
	heigth="$(json_config max_h)"
	min_x="$(json_config min_x)"
	min_y="$(json_config min_y)"
	main="${pre_png}0$post_png"
	extended=""

	for i in $(seq 1 $((num_screens - 1))); do
		local screen="$(json_config screens $i list)"
		local x="$(json_config $screen x)"
		local y="$(json_config $screen y)"
		extended+="-page +$x+$y $pre_png$i$post_png "
	done

	$debug && echo -e "${timeit_tab}convert -page \"${width}x${heigth}+$min_x+$min_y\" $main $extended -flatten $out"
	convert -page "${width}x${heigth}+$min_x+$min_y" $main $extended -flatten $out
}

_xlock() {
	i3lock -u -i $out
}

main() {
	# timeit get_autorandr_profile
	# timeit screenshot
	# timeit modify_seq
	# timeit combine
	timeit _xlock
}

test_func() {
	test "$(type $1 2>/dev/null)" || eval "$1(){ \$@; }"
}

# test_func timeit
dunstify "${BASH_SOURCE[@]}, $0"
# dunstify "$(type timeit)"
# dunstify "$(type set_colors)"
# env > /tmp/env_
# timeit main
