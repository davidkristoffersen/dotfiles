#!/usr/bin/bash

# Navigation
# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tree='tree -C'
alias cp="cp -i"     # confirm before overwriting something
alias df='pydf -h'   # human-readable sizes
alias free='free -m' # show sizes in MB

# Listing
alias l="exa -las type --git"
alias n="exa -ls type --git"
alias s="exa -1s type --git"
alias a="exa -1as type --git"
alias gl="exa -lGas type --git"
alias gn="exa -lGs type --git"
alias gs="exa -Gs type --git"
alias ga="exa -Gas type --git"
alias fs="exa -1as type --git \$(find . -maxdepth 1 -not -type d -a -not -xtype d | tail -n +2 | grep -Po \"^./\K.*\")"
alias ds="exa -1ads type --git \$(find . -maxdepth 1 -type d -o -xtype d | tail -n +2 | grep -Po \"^./\K.*\")"

alias li="exa -las type --git --git-ignore -I .git"
alias ni="exa -ls type --git --git-ignore -I .git"
alias si="exa -1s type --git --git-ignore -I .git"
alias ai="exa -1as type --git --git-ignore -I .git"
alias gli="exa -lGas type --git --git-ignore -I .git"
alias gni="exa -lGs type --git --git-ignore -I .git"
alias gsi="exa -Gs type --git --git-ignore -I .git"
alias gai="exa -Gas type --git --git-ignore -I .git"
alias fsi="exa -1as type --git --git-ignore -I .git \$(find . -maxdepth 1 -not -type d -a -not -xtype d | tail -n +2 | grep -Po \"^./\K.*\")"
alias dsi="exa -1ads type --git --git-ignore -I .git \$(find . -maxdepth 1 -type d -o -xtype d | tail -n +2 | grep -Po \"^./\K.*\")"

# Config
alias srcall="source $HOME/.bash_profile"
alias srcbash="source $HOME/.bashrc"
alias bashrc="vim $HOME/.bashrc"
alias bashconfig="vim -p $(echo $HOME/.bashrc $HOME/.bash.d/*.bash)"
alias srcprofile="source $HOME/.profile"
alias profileconfig="vim -p $(echo $HOME/.profile $HOME/.profile.d/*.bash)"
alias vimrc="vim $MYVIMRC"
alias vimhome="cd $DOTFILES_HOME/.vim"
alias vim_plugins="cd $HOME/.vim/bundle"
alias dotfiles="cd $DOTFILES"

# Terminal
alias c='clear'
alias cl="xclip -r -sel clip"

# Program specific
alias rip='gio trash'
alias lock='i3lock-fancy -pf inconsolata'
alias python='python3'
alias pcloud_start='pcloud > /dev/null 2>&1 &'
alias vless="$PAGER"
alias xdg-open="open"
