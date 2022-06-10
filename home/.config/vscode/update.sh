#!/usr/bin/bash

dst="$WIN_HOME/AppData/Roaming/Code/User"
conf="settings.json"
key="keybindings.json"

INFO=true
DEBUG=true

# Backup src to win dir
backup() {
	file_overwrite "$conf" "$dst/$conf.bak"
	file_overwrite "$key" "$dst/$key.bak"
}

# Recreate win links
link() {
	win_link "$conf" "$dst/$conf"
	win_link "$key" "$dst/$key"
}

main() {
	backup
	# link
}

pushd . >/dev/null
cd $(dirname ${BASH_SOURCE[0]})
main $@
popd >/dev/null
