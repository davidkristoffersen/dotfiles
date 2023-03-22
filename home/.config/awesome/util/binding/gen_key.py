#!/usr/bin/env python3

import itertools
from pprint import pprint
from typing import Dict, List

from keys import keycode_groups, keycodes, main_modifiers


def main():
    with open("comb.lua", "w") as f:
        f.write("local modkey = require('config.init').mod\n\n")

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

            first = True
            for k in keycodes:
                sp = ''
                if first:
                    sp = ' '
                    first = False
                f.write(
                    f"{c['b']}.{k[0]} {sp}= {{{{{c['v']}}}, '{k[1]}'}} -- {k[2]}\n")
            f.write("\n\n")

        f.write("return {\n")
        for c in combs:
            f.write(f"    {c['b']} = {c['b']},\n")
        f.write("}\n")

    print("Static Lua code generated.")


if __name__ == "__main__":
    main()
