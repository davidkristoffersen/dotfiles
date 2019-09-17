#!/bin/bash

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

export BROWSER="/usr/bin/firefox"
export SYSTEMD_EDITOR="vim"
export MYVIMRC="~/.vimrc"

export LATEX_HEADER='~/config/template.latex'
export MDPDF_SCRIPT='~/scripts/markdownpdf/mdpdf.py'

tabs 4

if [ ! -z "$SSH_TTY" ]; then
	. /opt/rh/devtoolset-8/enable
	. ~/.bashrc
fi
