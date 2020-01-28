#!/usr/bin/env bash

function script() {
	set_key data
	if key_exists data; then
		echo "Data: $(get_key data)"
	fi

	if subcmd_exists cache; then
		if key_exists new; then
			echo "New: $(get_key new)"
		fi
	fi
}

function lib_args() {
	# Create initial variables
	help_init "Example title text"

	# Add optio
	add_option -s a -m alpha	-d "54"		-v "number"	-i "ALSO VERY MUCH Make bool true Long text is incoming on this line you should be prepared yes indeed oh man this is scary ho nn"
	add_option -s b -m bravo	-d "true"				-i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soon"
	add_option 		-m charlie							-i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soon anvm aga muva nuvag vuag  vv vvmv gmvulv uqgmvu q  vugmuv luavgmln uvagma lwamuv awmlva vlawa vmlawvavu mlauvwavgmula uvgm avuvmg lmvu vugmluvgmlv uamvlu amlamuvla uvgmlavmgaluvamuv lamuvgla uvgmalv avlgmauvl gmauvl agmuv amuvg auvmlgaluvgmal uvglaguvvau nua mgn gmn gm gmnauuv vu mvlua uvlamvu avlamv alvmwav lamuva"
	add_option -s d -m delta				-v "text"	-i "Input text\nCan be multiline"
	add_option -s e -m echos	-d	"w"		-v "char"	-i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soo"
	add_option -s n -m november	-d "false"				-i "on this line yell though it is soon"
	add_option -s s -m sierra	-d "1"					-i "on this line yeis soon"
	add_option -s q -m quit		-d "0"					-i "on this line yeis soon"

	add_subcmd cache "Cache subcmd title"
	add_option -s n -m new		-d "34"		-v "number"	-i "This is a subcmd option" --subcmd "cache"
	add_option -s x -m xtra		-d "true"				-i "This is another subcmd option" --subcmd "cache"
}

#
# TEMPLATE LIBRARY INIT
#

# Source template library
lib="$HOME/.local/lib/bash/run_template_inner.sh"
if [ ! -f "$lib" ]; then echo "Library not found: $lib" >&2; exit; fi
. $lib
# Set argument options
lib_args
# Parse options
parse "$@"
# Run script
script
