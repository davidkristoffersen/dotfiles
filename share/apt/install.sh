#!/usr/bin/bash

main() {
	for pkg in $(cat "$1"); do
		echo -e "\nInstalling: $pkg"
		sudo apt install "$pkg"
	done
}

main "$1"