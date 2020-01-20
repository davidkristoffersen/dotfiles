#!/usr/bin/env bash


lib="$HOME/.local/lib/bash/run_template_inner.sh"
in="$HOME/.local/bin/run_template.sh"
out="."

if [ ! -f "$in" ]; then
	echo "Template does not exist: $in"
elif [ ! -f "$lib" ]; then
	echo "Template lib file does not exist: $lib"
fi

if [ ! -z "$1" ]; then
	out="$1"
fi

cp -n $in $out
