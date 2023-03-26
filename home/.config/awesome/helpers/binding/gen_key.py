#!/usr/bin/env python3

import itertools
from io import TextIOWrapper
from pprint import pprint
from typing import Callable, Dict, List

from keys import keycode_groups, keycodes, main_modifiers

FORCE_FORMAT = True
sp = ' ' if FORCE_FORMAT else ''


def comb(f: TextIOWrapper):
    f.write("local modkey = require('config.vars').mod\n\n")

    # Modifier names
    for mod in main_modifiers:
        f.write(f"local {mod['n']} = {mod['v']}\n")
    f.write("\n")

    # Initialize modifier tables
    combs: List[Dict[str, str]] = []
    for n_modifiers in range(1, len(main_modifiers) + 1):
        for mod_combination in itertools.combinations(main_modifiers, n_modifiers):
            binding = "".join([mod['b'] for mod in mod_combination])
            val = ", ".join([mod['n'] for mod in mod_combination])
            comment = " + ".join([mod['c'] for mod in mod_combination])
            combs.append({'b': binding, 'v': val, 'c': comment})
            f.write(f"local {binding} = {{}}\n")
    f.write("\n\n")

    # Fill modifier tables
    for c in combs:
        f.write(f"-- {c['c']}\n")
        for k in keycodes:
            f.write(
                f"{c['b']}.{k[0]} {sp}= {{{{{c['v']}}}, '{k[1]}'}} -- {k[2]}\n")
        f.write("\n\n")

    f.write("return {\n")
    for c in combs:
        f.write(f"    {c['b']} {sp}= {c['b']}, -- {c['c']}\n")
    f.write("}\n")


def mod(f: TextIOWrapper):
    f.write("local modkey = require('config.vars').mod\n\n")

    # Modifier names
    for mod in main_modifiers:
        f.write(f"local {mod['n']} = {mod['v']}\n")
    f.write("\n\n")

    # Initialize modifier tables
    combs: List[Dict[str, str]] = []
    for n_modifiers in range(1, len(main_modifiers) + 1):
        for mod_combination in itertools.combinations(main_modifiers, n_modifiers):
            binding = "".join([mod['b'] for mod in mod_combination])
            val = ", ".join([mod['n'] for mod in mod_combination])
            comment = " + ".join([mod['c'] for mod in mod_combination])
            combs.append({'b': binding, 'c': comment})
            f.write(f"local {binding} {sp}= {{{val}}}\n")
    f.write("\n\n")

    f.write("return {\n")
    for c in combs:
        f.write(f"    {c['b']} {sp}= {c['b']}, -- {c['c']}\n")
    f.write("}\n")


def key(f: TextIOWrapper):
    for name, val in keycode_groups.items():
        f.write(f"-- {val['c']}\n")
        f.write(f"local {name} = {{\n")
        for k in val['v']:
            f.write(f"    {k[0]} {sp}= '{k[1]}', -- {k[2]}\n")
        f.write("}\n\n")

    f.write("return {\n")
    for name, val in keycode_groups.items():
        f.write(f"    {name} {sp}= {name}, -- {val['c']}\n")
    f.write("}\n")


def run(file: str, func: Callable[[TextIOWrapper], None]):
    with open(file, "w") as f:
        try:
            func(f)
        except Exception as e:
            print(f"Error: {e}")
            return
    print(f"Generated: {file}")


def main():
    run("bind.lua", comb)
    run("mod.lua", mod)
    run("key.lua", key)


if __name__ == "__main__":
    main()
