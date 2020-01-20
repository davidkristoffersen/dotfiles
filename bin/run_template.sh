#!/bin/bash
# Bash script for gitlab-runner commands

function pre_parse() {
	. "$HOME/.local/lib/bash/run_template_inner.sh"
}
function post_parse() {
	parse $@
}
pre_parse

add_option -s r -m regist -i "Register the gitlab-runner"
add_option -s s -m start -i "Start the gitlab-runner"
add_option -m info -i "Info of the runner"
add_option -s k -m kill -i "Kill runner"
add_option -s a -m apex
add_option -s g -m grape -i "Grapes are good"

post_parse $@
