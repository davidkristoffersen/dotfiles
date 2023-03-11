#!/bin/bash

tmpdir="/tmp/"
overlay_img="$HOME/.local/share/icons/xlock/locked.png"

pre_png="${tmpdir}head_"
post_png=".png"
out="${tmpdir}screen.png"

debug=false
verbose=false
par=true
TIMEFORMAT="real: %3R, user: %3U, sys: %3S"
r="\e[0m"
b="\e[1m"
f="\e[2m"

main() {
	$debug && echo -en "${b}Starting:\t\t"
	timeit get_res
	$debug && echo -e "$r"
	if $par; then
		parallelize
	else
		sequential
	fi

	if [ "$num_screens" -gt 1 ]; then
		combine
	else
		cp "${pre_png}0$post_png" "$out"
	fi

	xlock
}

parallelize() {
	mapfile -t arr < <(parallel --tagstring "$tagstring" seq_main {} "$primary" ::: $screens)
}

sequential() {
	for i in $(seq 0 $((num_screens - 1))); do
		arr[$i]="$(seq_main $i "$primary")"
	done
}

get_res() {
	num_screens="$(xrandr | grep " connected" | wc -l)"
	res="$(xrandr | rg -o --pcre2 "((?<= connected )|(?<= connected primary ))\d[^ ]+" | tr 'x' ' ' | tr '+' ' ')"
	names="$(xrandr | rg -o --pcre2 "^[^ ]+(?= connected)")"
	primary="$(xrandr | rg -o --pcre2 "^[^ ]+(?= connected primary)")"

	tagstring='\033[30;3{=$_=++$::color%8=}m'
	# tagstring='{=1 $_=`date +%T-%Z`;chomp=} - {1}'
	screens="$(echo $(seq 0 $((num_screens - 1))) | tr " " "\n")"
}

timeit() {
	# start_time=$(date +%s%3N)
	$@
	# end_time=$(date +%s%3N)
	# elapsed_time=$((end_time - start_time))
	# elapsed_time_seconds=$(bc <<<"scale=3; $elapsed_time/1000")
	# $debug && printf "%.3f\t" $elapsed_time_seconds 1>&2
	$debug && t="$({ time $@; } 2>&1)"
	$debug && echo -e "$t" | tr -d '\n' 1>&2
	$debug && echo 1>&2
}

seq_main() {
	i=$1

	read w h x y <<<$(echo "$res" | sed -n "$((i + 1)) p")
	read name <<<$(echo "$names" | sed -n "$((i + 1)) p")
	# Check if current screen is primary
	[ "$2" == "$name" ] && primary=true || primary=false
	screen="$pre_png$i$post_png"

	$debug && $verbose && echo "# $name" 1>&2
	$debug && $verbose && echo "$name: $w x $h + $x + $y -> $screen" 1>&2

	# screenshot
	$debug && echo -en "${f}Scrotting:\t" 1>&2
	timeit scrot -o -a ${x},${y},${w},${h} $screen

	# blur
	$debug && echo -en "${f}Blurring:\t" 1>&2
	timeit gm convert $screen -scale 10% -blur 0x2.5 -resize 1000% $screen

	# pixelize
	$debug && echo -en "${f}Pixelizing:\t" 1>&2
	timeit pixelize.py $screen $screen 15

	# overlay if not primary
	if [[ -f $overlay_img ]] && ! $primary; then
		rw=$((w / 5))
		rh=$((h / 5))
		$debug && echo -en "${f}Overlaying:\t" 1>&2
		timeit gm composite -matte -gravity center -resize ${rw}x$rh $overlay_img $screen $screen
	fi

	pages="-page +$x+$y $screen "

	echo -e "$w|$h|$x|$y|$pages"
}
export -f seq_main timeit
export debug f r res names pre_png post_png overlay_img TIMEFORMAT verbose

combine() {
	root="${pre_png}0$post_png"
	tot_w=0
	tot_h=0

	$debug && $verbose && echo -e "\n$r${b}Combining images${r}"

	for ((i = 0; i < num_screens; i++)); do
		# Change delimiter to '|' and read from arr to w, h, x, y, pages
		IFS='|' read -e w h x y _pages <<<"$(echo -e "${arr[$i]}" | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g')"

		# Trim whitespace
		w="$(echo "$w" | tr -d "[:blank:]")"

		$debug && $verbose && echo -e "${arr[$i]}$r"
		$debug && $verbose && echo -e "${f}w: $w, h: $h, x: $x, y: $y, pages: $_pages$r"

		pages+="$_pages"
		[[ $((w + x)) -gt $tot_w ]] && tot_w=$((w + x))
		[[ $((h + y)) -gt $tot_h ]] && tot_h=$((h + y))
	done

	$debug && ! $verbose && echo 1>&2
	$debug && echo -en "$r${b}Combining:\t\t" 1>&2
	timeit convert -page "${tot_w}x${tot_h}+0+0" $root $pages -flatten $out
}

xlock() {
	# i3lock -u -i $out
	BLANK='#22222222'
	CLEAR='#ffffff10'
	DEFAULT='#f07416ff'
	TEXT='#c45f12cc'
	WRONG='#880000bb'
	KEY='#11bfaeff'
	VERIFYING='#c45f12bb'

	i3lock \
		-i $out \
		-c $BLANK \
		\
		--insidever-color=$CLEAR \
		--ringver-color=$VERIFYING \
		\
		--insidewrong-color=$CLEAR \
		--ringwrong-color=$WRONG \
		\
		--inside-color=$BLANK \
		--ring-color=$DEFAULT \
		--line-color=$BLANK \
		--separator-color=$DEFAULT \
		\
		--verif-color=$TEXT \
		--wrong-color=$TEXT \
		--time-color=$TEXT \
		--date-color=$TEXT \
		--layout-color=$TEXT \
		--keyhl-color=$KEY \
		--bshl-color=$KEY \
		\
		--screen 1 \
		--clock \
		--indicator \
		--time-str="%H:%M:%S" \
		--date-str="%A, %Y-%m-%d" \
		--keylayout 1

}

main
