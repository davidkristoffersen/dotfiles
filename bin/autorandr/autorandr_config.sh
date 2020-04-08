#!/usr/bin/env bash

profile="$HOME/.config/autorandr/$1"
test -d "$profile"
check_error $? "Autorandr profile directory does not exist: $profile"

config="$profile/config"
json="$(autorandr_config.py "$(cat $config)")"

out="$profile/config.json"
echo "$json" | jq --tab > "$out"
