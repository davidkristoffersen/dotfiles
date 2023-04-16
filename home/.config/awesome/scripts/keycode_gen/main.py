#!/usr/bin/env python3

from io import TextIOWrapper
from typing import Callable

from data import MK, ML, MU, KeyT, ModCombT, keycode_groups, keycodes
from data import modifier_combinations as mod_combs
from data import modifiers as mods
from data import mods_lower, mods_upper

FORCE_FORMAT = True
SP = ' ' if FORCE_FORMAT else ''

VARS_MODULE = "config.vars"
MODS = f"local mods = require('{VARS_MODULE}').mods"

AWESOME_ROOT = '../..'
ROOT = f'{AWESOME_ROOT}/helpers/keycode'
COMB = f'{ROOT}/combinations'
COMB_MOD_SEP = '-'
COMB_NAMES = ['tables', 'strings', 'strings_to_tables']

COMB_TYPE = '--- @type { [string]: KeyComb }\n'
STRING_TYPE = '--- @type { [string]: string }\n'

Func = Callable[[TextIOWrapper], None]
CombFunc = Callable[[TextIOWrapper, str], None]


def tables_init(f: TextIOWrapper, comb: ModCombT):
    f.write("{")
    for it, val in enumerate(comb.values()):
        f.write(f"_{val['u']}")
        if it < len(comb) - 1:
            f.write(", ")
    f.write("}")


def tables_fill(f: TextIOWrapper, val: ModCombT, k: KeyT):
    f.write(f"{{{mods_upper(val)}, '{k[1]}'}}")


def strings_fill(f: TextIOWrapper, key: str, comb: ModCombT, k: str):
    f.write("'")
    for it, val in enumerate(comb.values()):
        if key == MK._:
            continue
        if k == '_':
            if it < len(comb) - 1:
                f.write(f"{val['u']}{COMB_MOD_SEP}")
            else:
                f.write(f"{val['u']}'")
        else:
            f.write(f"{val['u']}{COMB_MOD_SEP}")
    if not k == '_':
        f.write(f"{k}'")


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
                f.write(f"local {mods_upper(val)} {SP}= ")
                tables_init(f, val)
                f.write("\n")
            f.write("\n\n")
        case 'strings_to_tables':
            # Get tables mappings
            f.write(f"local T = require('helpers.keycode.combinations.tables')\n\n\n")

            # Initialize mapping list
            f.write(COMB_TYPE)
            f.write("local strings_to_tables = {\n")

    # Initialize modifier tables
    if name in ['tables', 'strings']:
        for key, val in mod_combs.items():
            f.write(COMB_TYPE if name == 'tables' else STRING_TYPE)
            f.write(f"local {mods_lower(val)} {SP}= {{}}\n")
        f.write("\n\n")

    # Fill modifier tables
    for it, (key, val) in enumerate(mod_combs.items()):
        lower = mods_lower(val)
        upper = mods_upper(val)
        desc = ' + '.join([v['d'] for k, v in val.items()])
        f.write(f"-- {desc}\n")
        if not key == MK._:
            match name:
                case 'tables':
                    f.write(f"{key}.{ML._} {SP}= " +
                            "{" + upper + ", nil}\n")
                case 'strings':
                    f.write(f"{key}.{ML._} {SP}= ")
                    strings_fill(f, key, val, '_')
                    f.write(f"\n")
                case 'strings_to_tables':
                    f.write("[")
                    strings_fill(f, key, val, '_')
                    f.write(f"] {SP}= T.{key}.{ML._},\n")

        for k in keycodes:
            if name in ['tables', 'strings']:
                f.write(f"{lower}.{k[0]} {SP}= ")
            elif name == 'strings_to_tables':
                f.write("[")
                strings_fill(f, key, val, k[1])
                f.write(f"] {SP}= T.{lower}.{k[0]},")
            match name:
                case 'tables':
                    tables_fill(f, val, k)
                case 'strings':
                    strings_fill(f, key, val, k[1])
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
                f.write(
                    f"    {mods_lower(val)} {SP}= {mods_lower(val)}, -- {desc}\n")
            f.write("}\n")
        case 'strings_to_tables':
            f.write(f"return strings_to_tables -- Strings to tables mapping\n")


def keys(f: TextIOWrapper):
    for name, val in keycode_groups.items():
        f.write(f"--- {val['d']}\n")
        f.write(STRING_TYPE)
        f.write(f"local {name} = {{\n")
        for k in val['k']:
            f.write(f"    {k[0]} {SP}= '{k[1]}', -- {k[2]}\n")
        f.write("}\n\n")

    f.write("\nreturn {\n")
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
