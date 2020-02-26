#!/usr/bin/env bash

update_submodules() {
	echo
	$SUBMODULE || return
	git submodulepull; check_error $?
}
