#!/usr/bin/bash

#
# COLORS
#

set_colors() {
	# Colors
	declare -A colors=([black]=30
		[red]=31
		[green]=32
		[yellow]=33
		[blue]=34
		[magenta]=35
		[cyan]=36
		[white]=37
	)
	local pre='\033['
	export RESET="${pre}m"
	export BOLD="${pre}1m"
	export FAINT="${pre}2m"
	export ITALIC="${pre}3m"
	export UNDERLINE="${pre}4m"
	export CROSSEDOUT="${pre}9m"

	# Prompt specific
	export PRESET="\[${pre}m\]"
	export PBOLD="\[${pre}1m\]"
	export PFAINT="\[${pre}2m\]"
	export PITALIC="\[${pre}3m\]"
	export PUNDERLINE="\[${pre}4m\]"
	export PCROSSEDOUT="\[${pre}9m\]"

	for key in "${!colors[@]}"; do
		eval "export ${key^^}=\"${pre}${colors[$key]}m\""
		eval "export B${key^^}=\"${pre}1;${colors[$key]}m\""
		eval "export F${key^^}=\"${pre}2;${colors[$key]}m\""
		eval "export I${key^^}=\"${pre}3;${colors[$key]}m\""

		# Prompt specific
		eval "export P${key^^}=\"\[${pre}${colors[$key]}m\]\""
		eval "export PB${key^^}=\"\[${pre}1;${colors[$key]}m\]\""
		eval "export PF${key^^}=\"\[${pre}2;${colors[$key]}m\]\""
		eval "export PI${key^^}=\"\[${pre}3;${colors[$key]}m\]\""
	done
}

set_colors

#
# PRINT UTILITY FUNCTIONS
#

ERROR=false
WARN=false
INFO=false
DEBUG=false
LOG=false

export ERROR WARN INFO DEBUG LOG

print_error() {
	$ERROR && echo -e "$RED$@$RESET"
}

print_warn() {
	$WARN && echo -e "$MAGENTA$@$RESET"
}

print_info() {
	$INFO && echo -e "$YELLOW$@$RESET"
}

print_debug() {
	$DEBUG && echo -e "$GREEN$@$RESET"
}

print_log() {
	$LOG && echo -e "$FAINT$@$RESET"
}

export -f print_error print_warn print_info print_debug print_log
