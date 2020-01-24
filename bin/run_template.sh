#!/usr/bin/env bash

function script() {
# Script
if key_exists data; then
	echo "Data: $(get_key data)"
fi
}

function lib_args() {
	# Create initial variables
	help_init "Example title text"

	# Add option
	add_option -s a -m alpha -i "ALSO VERY MUCH Make bool true Long text is incoming on this line you should be prepared yes indeed oh man this is scary ho nn"
	add_option -s b -m bravo -i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soon"
	add_option -s c -m charlie -i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soon anvm aga muva nuvag vuag  vv vvmv gmvulv uqgmvu q  vugmuv luavgmln uvagm a vgmula uvgm avuvmg lmvu vugmluvgmlv uamvlu amlamuvla uvgmlav mgaluvamuv lamuvgla uvgmalv avlgmauvl gmauvl agmuv amuvg auvmlgaluvgmal uvglaguvvau "
	add_option -s d -m delta -i "Input text\nCan be multiline" -d "text"
	add_option -s e -m echo -i "Make bool true Long text is incoming on this line you should be prepared too as well though it is soo"
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
