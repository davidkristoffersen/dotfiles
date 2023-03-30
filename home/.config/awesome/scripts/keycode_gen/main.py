#!/usr/bin/env python3

from io import TextIOWrapper
from typing import Callable

from data import KeyT, ModCombT, keycode_groups, keycodes
from data import modifier_combinations as mod_combs
from data import modifiers as mods

FORCE_FORMAT = True
SP = ' ' if FORCE_FORMAT else ''

VARS_MODULE = "config.vars"
MODS = f"local mods = require('{VARS_MODULE}').mods"

AWESOME_ROOT = '../..'
ROOT = f'{AWESOME_ROOT}/helpers/keycode'
COMB = f'{ROOT}/combinations'
COMB_MOD_SEP = '-'
COMB_NAMES = ['tables', 'strings', 'strings_to_tables']

Func = Callable[[TextIOWrapper], None]
CombFunc = Callable[[TextIOWrapper, str], None]


def tables_init(f: TextIOWrapper, comb: ModCombT):
    f.write("{")
    for it, val in enumerate(comb.values()):
        f.write(f"_{val['u']}")
        if it < len(comb) - 1:
            f.write(", ")
    f.write("}")


def tables_fill(f: TextIOWrapper, key: str, k: KeyT):
    f.write(f"{{{key.upper()}, '{k[1]}'}}")


def strings_fill(f: TextIOWrapper, key: str, comb: ModCombT, k: KeyT):
    f.write("'")
    for val in comb.values():
        if key == 'n':
            continue
        f.write(f"{val['u']}{COMB_MOD_SEP}")
    f.write(f"{k[1]}'")


def combinations(f: TextIOWrapper, name: str):
    match name:
        case 'tables':
            # Get mods from config
            f.write(f'{MODS}\n\n\n')

            # Modifier names
            for val in mods.values():
                f.write(f"local _{val['u']} = mods.{val['l']}\n")
            f.write("\n\n")

            # Initialize inner modifier tables
            for key, val in mod_combs.items():
                f.write(f"local {key.upper()} {SP}= ")
                tables_init(f, val)
                f.write("\n")
            f.write("\n\n")
        case 'strings_to_tables':
            # Get tables mappings
            f.write(f"local T = require('helpers.keycode.combinations.tables')\n\n\n")

            # Initialize mapping list
            f.write("local strings_to_tables = {\n")

    # Initialize modifier tables
    if name in ['tables', 'strings']:
        for key, val in mod_combs.items():
            f.write(f"local {key} {SP}= {{}}\n")
        f.write("\n\n")

    # Fill modifier tables
    for it, (key, val) in enumerate(mod_combs.items()):
        desc = ' + '.join([v['d'] for k, v in val.items()])
        f.write(f"-- {desc}\n")
        for k in keycodes:
            if name in ['tables', 'strings']:
                f.write(f"{key}.{k[0]} {SP}= ")
            elif name == 'strings_to_tables':
                f.write("[")
                strings_fill(f, key, val, k)
                f.write(f"] {SP}= T.{key}.{k[0]},")
            match name:
                case 'tables':
                    tables_fill(f, key, k)
                case 'strings':
                    strings_fill(f, key, val, k)
            f.write(f" -- {k[2]}\n")

        if name in ['tables', 'strings']:
            f.write("\n\n")
        elif name == 'strings_to_tables':
            if it < len(mod_combs) - 1:
                f.write("\n")
    if name == 'strings_to_tables':
        f.write("}\n\n\n")

    match name:
        case 'tables' | 'strings':
            f.write("return {\n")
            for key, val in mod_combs.items():
                desc = ' + '.join([v['d'] for k, v in val.items()])
                f.write(f"    {key} {SP}= {key}, -- {desc}\n")
            f.write("}\n")
        case 'strings_to_tables':
            f.write(f"return strings_to_tables -- Strings to tables mapping\n")


def keys(f: TextIOWrapper):
    for name, val in keycode_groups.items():
        f.write(f"-- {val['d']}\n")
        f.write(f"local {name} = {{\n")
        for k in val['k']:
            f.write(f"    {k[0]} {SP}= '{k[1]}', -- {k[2]}\n")
        f.write("}\n\n")

    f.write("return {\n")
    for name, val in keycode_groups.items():
        f.write(f"    {name} {SP}= {name}, -- {val['d']}\n")
    f.write("}\n")


class File():
    func: Func

    def __init__(self, name: str, func: Func):
        self.name = name
        self.func = func
        self.path = f'{ROOT}/{self.name}.lua'

    def run(self):
        with open(self.path, "w") as f:
            try:
                self.func(f)
            except Exception as e:
                print(f"Error: {e}")
                raise e
        print(f"Generated: {self.path}")


class CombFile(File):
    def __init__(self, name: str, func: CombFunc):
        super().__init__(name, lambda f: func(f, self.name))
        self.path = f'{COMB}/{self.name}.lua'

        if not self.name in COMB_NAMES:
            raise Exception(f"Unknown combination type: {self.name}")


def main():
    File('keys', keys).run()
    CombFile('tables', combinations).run()
    CombFile('strings', combinations).run()
    CombFile('strings_to_tables', combinations).run()


if __name__ == "__main__":
    main()
