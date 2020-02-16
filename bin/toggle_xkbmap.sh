#!/bin/bash

(setxkbmap -query | grep -q "layout:\s\+no") && setxkbmap us || setxkbmap no
