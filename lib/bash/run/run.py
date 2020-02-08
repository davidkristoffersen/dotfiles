#!/usr/bin/env python3

from json import load as fload, dump as fdump, loads as oload,  dumps as odump
import sys, os
from pprint import pprint
from dotmap import DotMap
from config import *
from colorclass import Color

def gen_default_type(t):
    return DotMap({
        'u': default_usage,
        'o': default_option,
        'a': default_arg,
        's': default_subcmd,
    }[t])

def gen_default_json():
    json = DotMap(default_json)

    json.options.body.help = gen_default_type('o')
    json.options.body.help.header.text = 'help'
    json.options.body.help.body.text = 'Print this help menu.'

    json = DotMap(json)
    return json

def read(name):
    try:
        with open("test.json", 'r') as f:
            return fload(f)
    except Exception as e:
        print("File not found")
        return False

def modify(json):
    if not json:
        return gen_default_json()

    json = DotMap(json)

    json.args.body.file = gen_default_type('a')

    cache = gen_default_json()
    cache.title.header.text = "CACHE"
    json.subcmds.body.cache = gen_default_type('s')
    json.subcmds.cmd.cache = cache

    config = gen_default_json()
    config.title.header.text = "CONFIG"
    json.subcmds.body.config = gen_default_type('s')
    json.subcmds.cmd.config = config

    cache_config = gen_default_json()
    cache_config.title.header.text = "CACHE_CONFIG"
    json.subcmds.cmd.cache.subcmds.body.cache_config = gen_default_type('s')
    json.subcmds.cmd.cache.subcmds.cmd.cache_config = cache_config

    json = DotMap(json)
    return json

def print_json(json, rec=0):
    num_tabs = '\t' * rec
    _num_tabs = '\t' * (rec + 1)

    t = json.title
    u = json.usages
    o = json.options
    a = json.args
    s = json.subcmds

    # Title
    print()
    print(num_tabs + t.header.text + t.sep.text + t.body.text)
    print()

    # Usages
    print(num_tabs + u.header.text + u.sep.text)
    for _u in u.body:
        print(num_tabs + _u.header.text + _u.sep.text + _u.body.text)
    print()

    # Options
    print(num_tabs + o.header.text + o.sep.text)
    for _o in o.body.values():
        print(_num_tabs + _o.header.text + _o.sep.text + _o.body.text)
    print()

    # args
    print(num_tabs + a.header.text + a.sep.text)
    for _a in a.body.values():
        print(_num_tabs + _a.header.text + _a.sep.text + _a.body.text)
    print()

    # args
    print(num_tabs + s.header.text + s.sep.text)
    for _s in s.body.values():
        print(_num_tabs + _s.header.text + _s.sep.text + _s.body.text)
    print()

    # Subcmds
    for subcmd in s.cmd.values():
        print_json(subcmd, rec=rec+1)
    print()

def write(name, json):
    with open(name, 'w') as f:
        fdump(json, f)
    os.system('cat ' + name + ' | jq --tab | sponge ' + name)

if __name__ == "__main__":
    name = "test.json"

    json = read(name)
    json = modify(json)
    print_json(json)
    write(name, json)
