#!/usr/bin/env bash

function script() {
	if key_exists data; then
		echo "Data: $(get_key data)"
	fi
}

function lib_args() {
	# Create initial variables
	help_init "Example title text"

	# Add option
	add_option -s a -m alpha -i "ALSO VERY MUCH Make bool true Long text is incoming on this line you should be prepared yes indeed oh man this is scary ho nn" -v "number" -d "54"
	add_option -s b -m bravo -i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soon"
	add_option -m charlie -i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soon anvm aga muva nuvag vuag  vv vvmv gmvulv uqgmvu q  vugmuv luavgmln uvagma lwamuv awmlva vlawa vmlawvavu mlauvwavgmula uvgm avuvmg lmvu vugmluvgmlv uamvlu amlamuvla uvgmlavmgaluvamuv lamuvgla uvgmalv avlgmauvl gmauvl agmuv amuvg auvmlgaluvgmal uvglaguvvau nua mgn gmn gm gmnauuv vu mvlua uvlamvu avlamv alvmwav lamuva"
	add_option -s d -m delta -i "Input text\nCan be multiline" -v "text"
	add_option -s e -m echo -i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soo" -v "character" -d "n"
	add_option -s n -m november -i "on this line yell though it is soon"
	add_option -s q -m quit -i "on this line yeis soon"
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
