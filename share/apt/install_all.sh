#!/usr/bin/bash

main() {
	pkgs="$(cat "$1" | xargs)"
	sudo apt install $pkgs
}

main "$1"