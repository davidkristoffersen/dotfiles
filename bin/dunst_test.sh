#!/usr/bin/env bash

dunst_proc() {
	pkill dunst
	killall -q xfce4-notifyd
	printf "\nNEW RUN\n"
	dunst -print -config $DOTFILES_CONFIG/dunst/dunst.cfg 2>&1
}

if [ ! -z "$1" ]; then
	while true; do
		dunst_proc &
		title="Some app name"
		body="This is a really long text yes I like it"

		dunstify -a "1: $title" -u "low" "LOW: $body"
		dunstify -a "2: $title" -u "normal" "NORMAL: $body"
		dunstify -a "3: $title" -u "critical" "CRITICAL: $body"
		dunstify -a "1: $title" -u "low" "LOW: $body"
		dunstify -a "2: $title" -u "normal" "NORMAL: $body"
		dunstify -a "3: $title" -u "critical" "CRITICAL: $body"
		dunstify -a "1: $title" -u "low" "LOW: $body"
		dunstify -a "2: $title" -u "normal" "NORMAL: $body"
		dunstify -a "3: $title" -u "critical" "CRITICAL: $body"

		sleep 2
	done
else
	dunst_proc
fi
