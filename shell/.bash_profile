#!/usr/bin/bash

_bash_profile() {
	. ~/.util
	. ~/.profile
	. ~/.bashrc

	export SHELL_BASH_PROFILE=true
}

_bash_profile
unset -f _bash_profile
