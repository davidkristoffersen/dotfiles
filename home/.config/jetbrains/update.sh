#!/usr/bin/bash

dst_dir="$WIN_HOME"
src_dir="$DOTFILES_HOME/.vim/jetbrains"

conf=".ideavimrc"
conf_dir=".jetbrains.d"

INFO=true
DEBUG=true

main() {
	file_overwrite "$src_dir/$conf" "$dst_dir/$conf"
	dir_create "$dst_dir/$conf_dir"

	for file in $(ls -A1 $src_dir/$conf_dir); do
		local dst="$dst_dir/$conf_dir/$file"
		file_overwrite "$src_dir/$conf_dir/$file" "$dst_dir/$conf_dir/$file"
	done

}

pushd . >/dev/null
cd $(dirname ${BASH_SOURCE[0]})
main $@
popd >/dev/null
