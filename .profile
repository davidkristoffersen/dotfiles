#!/bin/bash

#
# Exports
#

# Formatting
export CLANG_FORMAT_CONFIG='{
ColumnLimit: 500,
UseTab: ForIndentation,
TabWidth: 1,
IndentWidth: 1,
AllowShortFunctionsOnASingleLine: false,
BreakBeforeBraces: Custom,
BraceWrapping: {
BeforeElse: true,
AfterEnum: true,
}
}'

# Editor
export SYSTEMD_EDITOR="vim"
export EDITOR="/usr/bin/vim"
export MYVIMRC="$HOME/.vimrc"

# Applications
export BROWSER="/usr/bin/firefox"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Latex
export LATEX_HEADER="$HOME/.config/latex/template.latex"
export MDPDF_SCRIPT="$HOME/scripts/markdownpdf/mdpdf.py"

# Directory structure
export XDG_CONFIG_HOME="$HOME/.config/"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_SRC_HOME="$HOME/.src"

#
# PATH
#

# Add to path if directory exists and is not already in path
function path_add() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="$1:$PATH"
	fi
}

# User's bin
path_add "$HOME/bin"
# User's private bin
path_add "$HOME/.local/bin"
# Cargo's bin
path_add "$HOME/.cargo/bin"

# Make path global
export PATH="$PATH"
