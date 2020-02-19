#!/usr/bin/env bash

appname="$1"
summary="$2"
body="$3"
icon="$4"
urgency="$5"

case $appname in
	Chromium)
		# Chrome notifica generator: https://tests.peter.sh/notification-generator
		notify-send -a "notification" -u "$urgency" -i false "WEB"
		;;
	telegram-desktop|discord)
		notify-send -a "notification" -u "$urgency" -i false "SOCIAL"
		;;
	Spotify)
		notify-send -a "notification" -u "$urgency" -i false "AUDIO"
		;;
	notification)
		;;
	*)
		notify-send -a "notification" -u "critical" -i false "UNKNOWN NAME: $appname"
		;;
esac
