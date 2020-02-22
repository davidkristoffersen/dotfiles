#!/usr/bin/env bash

test "$1"
check_error $? "Usage: $(basename $0) NAME"

port="$(autorandr --fingerprint | grep -ve "^eDP" | awk '{ print $1 }')"
test "$port"
check_error $? "No external monitor detected!"

arandr
edid="$(autorandr_edid.sh $port)"

autorandr -s $1; check_error $?
printf "$edid" > "$HOME/.config/autorandr/$1/edid.hex"
