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
    json.args.body.file.header.text = 'FILE...'
    json.args.body.file.body.text = 'File(s) to manage'

    cache = gen_default_json()
    cache.title.header.text = "CACHE"
    json.subcmds.body.cache = gen_default_type('s')
    json.subcmds.body.cache.header.text = 'cache'
    json.subcmds.body.cache.body.text = 'Manage cached data'
    json.subcmds.cmd.cache = cache

    config = gen_default_json()
    config.title.header.text = "CONFIG"
    json.subcmds.body.config = gen_default_type('s')
    json.subcmds.body.config.header.text = 'config'
    json.subcmds.body.config.body.text = 'Manage settings'
    json.subcmds.cmd.config = config

    cache_config = gen_default_json()
    cache_config.title.header.text = "CACHE_CONFIG"
    json.subcmds.cmd.cache.subcmds.body.cache_config = gen_default_type('s')
    json.subcmds.cmd.cache.subcmds.body.cache_config.header.text = 'cache_config'
    json.subcmds.cmd.cache.subcmds.body.cache_config.body.text = 'Manage cache settings'
    json.subcmds.cmd.cache.subcmds.cmd.cache_config = cache_config

    json = DotMap(json)
    return json

def colorize(text, col):
    return Color('{' + col + '}' + text + '{/' + col + '}')

def _print_json(json, num_tabs, body=True):
    print(num_tabs, colorize(json.header.text + json.sep.text, json.header.col), end='')
    if body:
        print(colorize(json.body.text, json.body.col))
    else:
        print()

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
    _print_json(t, num_tabs)
    print()

    # Usages
    _print_json(u, num_tabs, body=False)
    for _u in u.body:
        _print_json(_u, _num_tabs)
    print()

    # Options
    _print_json(o, num_tabs, body=False)
    for _o in o.body.values():
        _print_json(_o, _num_tabs)
    print()

    # Args
    _print_json(a, num_tabs, body=False)
    for _a in a.body.values():
        _print_json(_a, _num_tabs)
    print()

    # Subcmds
    _print_json(s, num_tabs, body=False)
    for _s in s.body.values():
        _print_json(_s, _num_tabs)
    print()

    # Recurse subcmds
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
