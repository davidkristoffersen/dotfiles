#!/usr/bin/env python

from subprocess import PIPE, run
from json import load as load_f, dump as dump_f
from pprint import pprint

class BashCmd():
    def __init__(self, cmd):
        self.result = run(cmd, stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True)
        self.ret = self.result.returncode
        self.out = self.result.stdout
        self.err = self.result.stderr

def update_file(path, pkgs):
    with open(path.out, 'r') as f:
        print("\nUpdating: " + path.out)
        body = load_f(f)
        all_pkgs = [p for val in body.values() for p in val]
        for pkg in pkgs.out.split('\n')[:-1]:
            if not pkg in all_pkgs:
                print(pkg + " (w, b, o): ", end='')
                inp = input()
                if inp == 'w':
                    body['whitelist'].append(pkg)
                elif inp == 'b':
                    body['blacklist'].append(pkg)
                elif inp == 'o':
                    body['other'].append(pkg)

    with open(path.out, 'w') as f:
        dump_f(body, f)
    BashCmd("cat " + path.out + " | jq --tab | sponge " + path.out)
    return body['whitelist']

if __name__ == "__main__":
    path = "$DOTFILES_SHARE/pacman"
    foreign_path = BashCmd("echo -n " + path + "/foreign.json")
    native_path = BashCmd("echo -n " + path + "/native.json")

    foreign_pkgs = BashCmd("sudo pacman -Qqettm")
    native_pkgs = BashCmd("sudo pacman -Qqettn")

    foreign_install = update_file(foreign_path, foreign_pkgs)
    native_install = update_file(native_path, native_pkgs)

    print(foreign_install)
    print(native_install)
