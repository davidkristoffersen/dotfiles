#!/usr/bin/bash

for file in ~/.bash_completion.d/*; do
	[ -f "$file" ] && . $file
done
