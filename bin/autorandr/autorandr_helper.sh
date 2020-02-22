#!/usr/bin/env bash

profile="$(autorandr_profile.sh)"
autorandr -l $profile
nitrogen --restore
