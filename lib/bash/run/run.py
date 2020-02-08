#!/usr/bin/env python3

from json import load as fload, dump as fdump, loads as oload,  dumps as odump
import sys
from pprint import pprint
from dotmap import DotMap
from config import *
from colorclass import Color

def gen_default_json():
    return DotMap(default_json)

def read(name):
    try:
        with open("test.json", 'r') as f:
            return fload(f)
    except Exception as e:
        print("File not found")
        return False

def modify(json):
    if not json:
        json = gen_default_json()
        json.title.header = "MAIN"
        return json

    json = DotMap(json)

    cache = gen_default_json()
    cache.title.header = "CACHE"
    config = gen_default_json()
    config.title.header = "CONFIG"
    cache_config = gen_default_json()
    cache_config.title.header = "CACHE_CONFIG"

    json.subcmds.cmds.cache = cache
    json.subcmds.cmds.config = config
    json.subcmds.cmds.cache.subcmds.cmds.cache_config = cache_config

    return json

def print_json(json, rec=0):
    num_tabs = '\t' * rec
    for key, val in json.items():
        print('\n' + num_tabs + key + '\n' + num_tabs + val.header + val.sep + str(val.body))

    for subcmd in json.subcmds.cmds.values():
        print_json(subcmd, rec=rec+1)
    print()

def write(name, json):
    with open(name, 'w') as f:
        fdump(json, f)

if __name__ == "__main__":
    name = "test.json"

    json = read(name)
    json = modify(json)
    print_json(json)
    write(name, json)
