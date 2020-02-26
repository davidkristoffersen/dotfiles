#!/usr/bin/env bash

link_header() {
	printf "$RESET$FAINT"
	printf "#%.0s" $(seq 1 $((${#1} + 4)))
	printf "\n$FAINT# $RESET$BYELLOW$1$RESET $FAINT#\n"
	printf "#%.0s" $(seq 1 $((${#1} + 4)))
	printf "$RESET\n"
}

link_section() {
	printf "\n$FAINT# $RESET$BCYAN$1$RESET\n"
}
