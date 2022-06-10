#!/usr/bin/bash

_call_bash_func() {
	local filepath="$1"
	local func="$2"
	shift 2

	bash "$filepath" "$func" $@
}

# Functions has to start with alpha(A-Za-z) to be generated
# Underscore can be used to ignore functions
main() {
	local dir="$DOTFILES_SHELL/.bash.d/funcs"
	local func_decl=""
	local func_export=""

	for file in $(ls -A1 "$dir" | grep -e ".*\.bash"); do
		for func in $(cat "$dir/$file" | grep -Po "^[A-Za-z].*(?=\(\) {$)"); do
			func_decl="$(echo -e "$func_decl\n$func() {\n\t_call_bash_func \"$dir/$file\" \"$func\" \$@\n}\n ")"
			func_export="$func_export $func"
		done
	done

	eval "$func_decl"
	export -f $func_export
}

call_bash_func_if_exist() {
	local func="$1"
	shift
	test "$(type -t "$func")" = 'function' && "$func" $@
}

export -f call_bash_func_if_exist

main
