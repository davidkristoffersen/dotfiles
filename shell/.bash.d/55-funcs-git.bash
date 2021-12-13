#!/usr/bin/bash

format_patch() {
	git format-patch --base=$1 $1..$2 --stdout >"../patches/patch-$1-$2.patch"
}

hostname_master() {
	name="$1"
	tracepath -b 129.242.16.30 | grep "$name" | grep -e '^ 1:'
}

export -f format_patch hostname_master
