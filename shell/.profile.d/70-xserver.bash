#!/usr/bin/bash

if $XDISPLAY; then
	xrdb -merge $HOME/.Xresources
fi
