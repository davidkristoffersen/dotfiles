#!/usr/bin/env python

from subprocess import PIPE, run
from json import load as load_f, dump as dump_f, loads
from pprint import pprint

from _ctypes import PyObj_FromPtr
from string import ascii_lowercase as letters
import json
import re
import sys
from tabulate import tabulate

class NoIndent(object):
    """ Value wrapper. """
    def __init__(self, value):
        self.value = value

class MyEncoder(json.JSONEncoder):
    FORMAT_SPEC = '@@{}@@'
    regex = re.compile(FORMAT_SPEC.format(r'(\d+)'))

    def __init__(self, **kwargs):
        # Save copy of any keyword argument values needed for use here.
        self.__sort_keys = kwargs.get('sort_keys', None)
        super(MyEncoder, self).__init__(**kwargs)

    def default(self, obj):
        return (self.FORMAT_SPEC.format(id(obj)) if isinstance(obj, NoIndent)
                else super(MyEncoder, self).default(obj))

    def encode(self, obj):
        format_spec = self.FORMAT_SPEC  # Local var to expedite access.
        json_repr = super(MyEncoder, self).encode(obj)  # Default JSON.

        # Replace any marked-up object ids in the JSON repr with the
        # value returned from the json.dumps() of the corresponding
        # wrapped Python object.
        for match in self.regex.finditer(json_repr):
            # see https://stackoverflow.com/a/15012814/355230
            id = int(match.group(1))
            no_indent = PyObj_FromPtr(id)
            json_obj_repr = json.dumps(no_indent.value, sort_keys=self.__sort_keys)

            # Replace the matched id string with json formatted representation
            # of the corresponding Python object.
            json_repr = json_repr.replace(
                            '"{}"'.format(format_spec.format(id)), json_obj_repr)

        return json_repr

class BashCmd():
    def __init__(self, cmd):
        self.result = run(cmd, stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True)
        self.ret = self.result.returncode
        self.out = self.result.stdout
        self.err = self.result.stderr

def default_pkg(name):
    return {"desc": ""}

def update_file(path, pkgs):
    with open(path.out, 'r') as f:
        body = load_f(f)
        all_pkgs = [p for val in body.values() for p in val.keys()]
        for pkg in pkgs.out.split('\n')[:-1]:
            if not pkg in all_pkgs:
                print(pkg + " (w, b, o): ", end='')
                inp = input()
                if inp == 'w':
                    body['whitelist'][pkg] = default_pkg(pkg)
                elif inp == 'b':
                    body['blacklist'][pkg] = default_pkg(pkg)
                elif inp == 'o':
                    body['other'][pkg] = default_pkg(pkg)

        body_f = {}
        for key in body.keys():
            body_f[key] = {}
            for key2, val in body[key].items():
                body_f[key][key2] = NoIndent(val)
        body_f = str(json.dumps(body_f, cls=MyEncoder, sort_keys=True, indent=4))
        BashCmd("echo '" + body_f + "' > " + path.out)
    return body['whitelist']

def print_file(pkgs):
    if len(sys.argv) > 2 and sys.argv[2] == "print":
        out = []
        for key, val in pkgs.items():
            out.append([key, val['desc']])
        print(tabulate(out, headers=['Name', 'Description']))
    else:
        for key, val in pkgs.items():
            print(key, end=' ')

if __name__ == "__main__":
    path = "$DOTFILES_SHARE/pacman"
    foreign_path = BashCmd("echo -n " + path + "/foreign.json")
    native_path = BashCmd("echo -n " + path + "/native.json")

    if len(sys.argv) > 1 and sys.argv[1] == "foreign":
        foreign_pkgs = BashCmd("sudo pacman -Qqettm")
        foreign_install = update_file(foreign_path, foreign_pkgs)
        print_file(foreign_install)
    else:
        native_pkgs = BashCmd("sudo pacman -Qqettn")
        native_install = update_file(native_path, native_pkgs)
        print_file(native_install)
