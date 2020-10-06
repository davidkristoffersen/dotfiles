#!/usr/bin/env python3

from json import load
from sys import argv

if len(argv) < 2: pass
elif len(argv) == 2:
    with open(argv[1], 'r') as f:
        print(load(f))
else:
    with open(argv[1], 'r') as f:
        json = load(f)
        if argv[2] in json:
            print(json[argv[2]])
