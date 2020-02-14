#!/usr/bin/env bash
# Setup installation of config files

config="$HOME/.config/config"

# Clone the git repository
printf "git clone https://github.com/davidkristoffersen/config.git $config\n"

printf "cd $config\n"
printf "./install.sh\n"
