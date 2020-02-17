#!/usr/bin/env bash

while true; do
	killall -q xfce4-notifyd
	printf "\nNEW RUN\n"
	dunst -config $DOTFILES/dunst.cfg 2>&1 &


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
	pkill dunst
done
