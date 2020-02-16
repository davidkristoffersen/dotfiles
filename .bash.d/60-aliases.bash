#!/usr/bin/env bash

# Navigation
# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tree='tree -C'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Listing
alias lll="exa -ls type --git"
alias lla="exa -las type --git"
alias ll="exa -s type --git"
alias la="exa -as type --git"

alias srcbash="source $HOME/.bashrc"
alias bashrc="vim $HOME/.bashrc"
alias bashconfig="vim -p $(echo .bashrc .bash.d/*.bash)"
alias profileconfig="vim -p $(echo .profile .profile.d/*.bash)"
alias vimrc="vim $MYVIMRC"
alias vim_plugins="cd $HOME/.vim/bundle"
alias dotfiles="cd $DOTFILES"

alias c='clear'

# Program specific
alias rip='gio trash'
alias lock='i3lock-fancy -pf inconsolata'
alias python='python3'
alias pcloud_start='pcloud > /dev/null 2>&1 &'
alias vless="$PAGER"
