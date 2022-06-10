#!/usr/bin/bash

#
# HELP UTILITY HELP FUNCTIONS
#

_help_print_help() {
	help_print "help_print [SCRIPT]" \
		"First argument: Script name" \
		"The rest have each 1-3 values split by <TAB>, e.g.:" \
		"t	testflag	This is a test flag"
}

_help_option_help() {
	help_print "help_option" \
		"One argument with 1-3 values split by <TAB>, e.g.:" \
		"t	testflag	This is a test flag"
}

export -f _help_print_help _help_option_help
