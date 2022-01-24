#!/usr/bin/bash

# Fix for hanging gui apps in wslg
if $SHELL_WSLG; then
	export DISPLAY="$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0"
fi
