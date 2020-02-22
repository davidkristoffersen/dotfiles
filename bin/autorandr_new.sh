#!/usr/bin/env bash

if [ -z "$1" ]; then
	printf "Usage: $0 NAME\n"
	exit
fi

port="$(xrandr | grep " connected" | grep -ve "^eDP-1" | awk '{ print $1 }')"
if [ -z "$port" ]; then
	printf "No external monitor detected!\n"
	exit
fi

arandr

edid="$(autorandr_edid.sh $port)"

autorandr -s $1; check_error $?
printf "$edid" > "$HOME/.config/autorandr/$1/edid.hex"
