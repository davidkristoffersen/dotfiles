#!/usr/bin/env bash

# Parse dircolors
if [ ! -f $HOME/.exa_colors ]; then
	exit
fi

exa_dircolors() {
	local parsed="$(dircolors -b ~/.exa_colors | head -n +1 | head -c -3 | tail -c +12)"

	a() {
		parsed+="$1=$2:"
	}

	# ```dircolors
	# PERMISSIONS
	a ur "0"	# User +r bit
	a uw "0"	# User +w bit
	a ux "0"	# User +x bit (files)
	a ue "0"	# User +x bit (file types)
	a gr "0"	# Group +r bit
	a gw "0"	# Group +w bit
	a gx "0"	# Group +x bit
	a tr "0"	# Others +r bit
	a tw "0"	# Others +w bit
	a tx "0"	# Others +x bit
	a su "0"	# Higher bits (files)
	a sf "0"	# Higher bits (other types)
	a xa "0"	# Extended attribute marker

	# FILE SIZES
	# a sn "0"	# Size numbers
	# a sb "0"	# Size unit
	# a df "0"	# Major device ID
	# a ds "0"	# Minor device ID

	# OWNERS AND GROUPS
	# a uu "0"	# A user that’s you
	# a un "0"	# A user that’s not
	# a gu "0"	# A group with you in it
	# a gn "0"	# A group without you

	# HARD LINKS
	# a lc "0"	# Number of links
	# a lm "0"	# A multi-link file

	# GIT
	# a ga "0"	# New
	# a gm "0"	# Modified
	# a gd "0"	# Deleted
	# a gv "0"	# Renamed
	# a gt "0"	# Type change

	# DETAILS AND METADATA
	# a xx "0"	# Punctuation
	# a da "0"	# Timestamp
	# a in "0"	# File inode
	# a bl "0"	# Number of blocks
	# a hd "0"	# Table header row
	# a lp "0"	# Symlink path
	# a cc "0"	# Control character

	# OVERLAYS
	# a bO "0"	# Broken link path
	# $```dircolors

	printf "EXA_COLORS='$parsed';\nexport EXA_COLORS"
}

eval "$(exa_dircolors)"
