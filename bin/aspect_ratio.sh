#!/usr/bin/bash

help() {
	echo -ne "Usage: $(basename $0) [OPTIONS] FILE\n"
	out="$(echo -e "\t-p,\t--phone\tPhone aspect ratio\n")"
	out="$(echo -e "$out\n\t-t7,\t--tablet7\t7-Inch tablet aspect ratio\n")"
	out="$(echo -e "$out\n\t-t10,\t--tablet10\t10-Inch tablet aspect ratio\n")"
	out="$(echo -e "$out\n\t-f,\t--feature\tFeature graphic size\n")"
	out="$(echo -e "$out\n\t-n,\t--name\tCore name of output file\n")"
	out="$(echo -e "$out\n\t-d,\t--debug\tEnable debug prints\n")"
	out="$(echo -e "$out\n\t-h,\t--help\tPrint this help message.\n")"
	echo -e "$out" | column -s $'\t' -t
	exit
}

parse_args() {
	PHONE=false
	TABLET7=false
	TABLET10=false
	FEATURE=false
	DEBUG=false
	NAME=""
	file=""

	if [ "$#" -lt 1 ]; then
		echo -e "Missing argument: file\n"
		help
	fi

	while (("$#")); do
		case "$1" in
		-p | --phone)
			PHONE=true
			shift
			;;
		-t7 | --tablet7)
			TABLET7=true
			shift
			;;
		-t10 | --tablet10)
			TABLET10=true
			shift
			;;
		-f | --feature)
			FEATURE=true
			shift
			;;
		-n | --name)
			NAME="$2"
			shift
			shift
			;;
		-d | --debug)
			DEBUG=true
			shift
			;;
		-h | --help)
			help
			;;
		*)
			! $TABLET7 && ! $TABLET10 && ! $FEATURE && PHONE=true
			file="$1"
			break
			;;
		esac
	done

	if [ -z "$file" ]; then
		echo -e "Missing argument: file\n"
		help
	fi

	if [ ! -f "$file" ]; then
		echo -e "File does not exist: $file\n"
		help
	fi
}

resize() {
	ext="${file##*.}"
	fname="$(basename "$file" "$ext")"

	width="$(identify -format '%w' "$file")"
	height="$(identify -format '%h' "$file")"
	ow="$width"
	oh="$height"

	PORTRAIT=true
	orientation="portrait"
	if [ $width -gt $height ]; then
		PORTRAIT=false
		orientation="landscape"
	fi

	if $PHONE; then
		set_out "phone"
	elif $TABLET7; then
		set_out "tablet7"
	elif $TABLET10; then
		set_out "tablet10"
	elif $FEATURE; then
		set_out "feature"
	fi

	set_size
	print_result
	convert -resize "${width}X$height!" $file $out
}

float() {
	bc <<<"scale=4;$1"
}

int() {
	printf "%.0f" "$(float "$1")"
}

set_size() {
	if ! $FEATURE; then
		ratio="$(float "16 / 9")"
		$PORTRAIT && width="$(int "$height / $ratio")"
		! $PORTRAIT && height="$(int "$width / $ratio")"
	else
		width="1024"
		height="500"
	fi
}

set_out() {
	if [ ! -z "$NAME" ]; then
		fname="$NAME."
	fi

	if ! $FEATURE; then
		out="$1-$orientation-$fname$ext"
	else
		out="$1-$fname$ext"
	fi
}

print_result() {
	p="Name:\t$file\t->\t$out"
	p="$p\nRatio:\t${ow}X${oh}\t->\t${width}X$height"
	$DEBUG && echo -e "$p" | column -s $'\t' -t
}

main() {
	parse_args $@
	resize
}

pushd . >/dev/null
main $@
popd >/dev/null
