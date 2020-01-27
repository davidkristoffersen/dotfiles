#!/usr/bin/env bash
debug=false
info="$(xdpyinfo -ext all 2>/dev/null | sed '/^  head #/!d;s///')"

while IFS=' :x@,' read i w h x y; do
	if [ "$i" == 0 ]; then
		declare -gA main_info=([w]=$w [h]=$h [x]=$x [y]=$y)
	elif [ "$i" == 1 ]; then
		declare -gA extended_info=([w]=$w [h]=$h [x]=$x [y]=$y)
	fi
    import -window root -crop ${w}x$h+$x+$y "/tmp/head_$i.png"
    if $debug; then echo "import -window root -crop ${w}x$h+$x+$y \"/tmp/head_$i.png\""; fi
done <<< "$info"
